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
    

    func download(gameImageforGameID gameID: String, completion: @escaping (UIImage?) -> ()) {
        gameImageManager.download(imageWithName: gameID) { (image) in
            completion(image)
        }
    }
    
    func download(questWithID questID: String, completion: @escaping (Quest?, Error?) -> ()) {
        questDB.child(questID).observeSingleEvent(of: .value) { (dataSnapshot) in
            if var quest = Quest(snapshot: dataSnapshot) {
                
                self.questImageManager.download(imageWithName: questID, completion: { (questCoverImage) in
                    quest.image = questCoverImage
                    completion(quest, nil)
                })
                
            } else {
                completion(nil, nil)
            }
        }
    }
    
    func downloadAllGames(completion: @escaping ([Game], Error?) -> ()) {
        gameDB.observeSingleEvent(of: .value) { (dataSnapshot) in
            var gameList : [Game] = []
            for gameSnapShot in dataSnapshot.children.allObjects as! [DataSnapshot] {
                if let game = Game(snapshot: gameSnapShot){
                    gameList.append(game)
                } else {
                    completion([], GameError.failedFetchingGame)
                }
            }
            
            // games in gameList - beinhalten kein Titelbild + keine Quests
            let group = DispatchGroup()
            
            for (index, game) in gameList.enumerated() {
                
                group.enter()
                self.download(gameImageforGameID: game.id, completion: { (gameCoverImage) in
                    gameList[index].image = gameCoverImage
                    group.leave()
                })
                
                for questID in game.questIDs {
                    group.enter()
                    self.download(questWithID: questID, completion: { (quest, error) in
                        guard let quest = quest else { return }
                        gameList[index].quests.append(quest)
                        group.leave()
                    })
                }
            }
            
            group.notify(queue: .main, execute: {
                // quests in die richtige Reihenfolge sortieren
                
                for (gameIndex, game) in gameList.enumerated() {
                    
                    for (index, questID) in game.questIDs.enumerated() {
                        if let questIndex = game.quests.index(where: { $0.id == questID }) {
                            gameList[gameIndex].quests.swapAt(questIndex, index)
                        }
                    }
                    
                }
                
                completion(gameList, nil)
            })
            
        }

    }
    
}

