//
//  GameDownloadController.swift
//  GeoCaching
//
//  Created by Philipp on 13.06.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class GameDownloadController {
    
    private var model = GameSingleton.sharedInstance
    
    private var gameDB: DatabaseReference
    private var questDB: DatabaseReference
    
    private var questImageManager: FirebaseImageManager
    private var gameImageManager: FirebaseImageManager
    
    
    init() {
        questDB = Database.database().reference().child("quests")
        gameDB = Database.database().reference().child("games")
        
        questImageManager = FirebaseImageManager(database: .quest)
        gameImageManager = FirebaseImageManager(database: .game)
    }
    
    // MARK: - Quest
    
    private func downloadAllGames(completion: @escaping ([Game]?, Error?) -> ()) {
        gameDB.observeSingleEvent(of: .value) { (dataSnapshot) in
            var gameList : [Game] = []
            for gameSnapShot in dataSnapshot.children.allObjects as! [DataSnapshot] {
                if let game = Game(snapshot: gameSnapShot){
                    gameList.append(game)
                }else{
                    completion(nil, GameError.failedFetchingGame)
                }
            }
            completion(gameList, nil)
        }
    }
    
    private func downloadGame(for id: String, completion: @escaping (Game?, Error?) -> ()) {
        gameDB.child(id).observeSingleEvent(of: .value) { (dataSnapshot) in
            if let game = Game(snapshot: dataSnapshot){
                completion(game,nil)
            }else{
                completion(nil, GameError.failedFetchingGame)
            }
        }
    }
    
    private func downloadGameWithQuests(for id: String, completion: @escaping (Game?, Error?) -> ()) {
        downloadGame(for: id) { (downloadedGame, error) in
            var gameToPass : Game? = nil
            if let error = error{
                completion(nil, error)
            }else{
                if let game = downloadedGame{
                    self.downloadQuests(for: game) { (downloadedQuestList, error) in
                        if let error = error{
                            completion(nil, error)
                        }else{
                            gameToPass = game
                            gameToPass?.quests = downloadedQuestList!
                            completion(gameToPass, nil)
                        }
                    }
                }
            }
        }
    }
    
    func downloadQuests(for game: Game, completion: @escaping ([Quest]?,Error?) -> ()) {
        var questList : [Quest] = []
        let group = DispatchGroup()
        for questID in game.questIDs {
            group.enter()
            questDB.child(questID).observeSingleEvent(of: .value) { (dataSnapshot) in
                if let quest = Quest(snapshot: dataSnapshot){
                    questList.append(quest)
                }else{
                    completion(nil,QuestError.failedFetchingQuest)
                }
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            completion(questList, nil)
        }
    }
    
    func fetchAllGames(notificationName : Notification.Name? = nil){
        downloadAllGames { (downloadedGames, error) in
            if let error = error{
                print(error)
            }else{
                guard let games = downloadedGames else{ return }
                self.model.games = games
                if let notification = notificationName{
                    NotificationCenter.default.post(Notification(name: notification))
                }
            }
        }
    }
    
    func fetchAllGamesWithQuests(notificationName : Notification.Name? = nil){
        downloadAllGames { (downloadedGames, error) in
            if let error = error {
                print(error)
            }else{
                guard let games = downloadedGames else { return }
                self.model.games = games
                let group = DispatchGroup()
                for game in games{
                    group.enter()
                    let index = self.getGameIndex(for: game.id)
                    self.downloadGameWithQuests(for: game.id, completion: { (downloadedGame, error) in
                        if let error = error{
                            print(error)
                        }else{
                            guard let newGame = downloadedGame else { return }
                            self.model.games[index] = newGame
                            print(newGame.name)
                        }
                        group.leave()
                    })
                }
                group.notify(queue: DispatchQueue.main){
                    if let notification = notificationName{
                        NotificationCenter.default.post(Notification(name: notification))
                    }
                }
            }
        }
    }
    
    func fetchQuests(notificationName : Notification.Name? = nil, for game: Game){
        downloadQuests(for: game) { (downloadedQuests, error) in
            if let error = error{
                print(error)
            }else{
                guard let quests = downloadedQuests else { return }
                let index = self.getGameIndex(for: game.id)
                self.model.games[index].quests = quests
                if let notification = notificationName{
                    NotificationCenter.default.post(Notification(name: notification))
                }
            }
        }
    }
    
    private func getGameIndex(for id : String) -> Int {
        for (index, element) in model.games.enumerated() {
            if element.id == id{
                return index
            }
        }
        return -1
    }
    
    func getAllGames() -> [Game]{
        return model.games
    }
    
    func getGame(for id: String) -> Game{
        return model.games.filter{ $0.id == id}[0]
    }
    
}

class GameSingleton{
    
    static let sharedInstance = GameSingleton()
    
    var games : [Game] = []
    
    private init() {}
}
