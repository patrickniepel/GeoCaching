//
//  UploadController.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 16.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage


struct GameUploadController {
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
    
    func upload(quest: Quest, completion: @escaping (Error?) -> ()) {
        questDB.child(quest.id).setValue(quest.toDictionary) { (error, _) in
            if let error = error {
                completion(error)
            } else {
                if let image = quest.image {
                    self.questImageManager.upload(image: image, withImageName: quest.id, completion: { (error) in
                        completion(error)
                    })
                } else {
                    // TODO: ✅ kein Bild vorhanden error zurück geben
                }
            }
        }
    }
    
    
    // MARK: - Game
    
    func upload(game: Game, completion: @escaping ((progress: Double, error: Error?)) -> ()) {
        gameDB.child(game.id).setValue(game.toDictionary) { (error, _) in
            if let error = error {
                completion((0, error))
            } else {
                if let image = game.image {
                    self.gameImageManager.upload(image: image, withImageName: game.id, completion: { (error) in
                        
                        var numberOfUploadedQuests = 0
                        for quest in game.quests {
                            self.upload(quest: quest, completion: { (error) in
                                numberOfUploadedQuests += 1
                                let progress = Double(numberOfUploadedQuests) / Double(game.quests.count)
                                completion((progress, error))
                            })
                        }
                        
                    })
                } else {
                    // TODO: ✅ kein Bild vorhanden error zurück geben
                }
            }
        }
    }
    
    func updateRating(ofGameID gameID: String, withRating newRating: Int) {
        gameDB.child(gameID).observeSingleEvent(of: .value) { (dataSnapshot) in
            if var game = Game(snapshot: dataSnapshot) {
                game.ratings.append(newRating)
                self.gameDB.child(gameID).setValue(game)
            }
        }
    }
}






