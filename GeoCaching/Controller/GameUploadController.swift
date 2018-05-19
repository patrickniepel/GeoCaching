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
    
    func upload(game: Game, completion: @escaping (Error?) -> ()) {
        gameDB.child(game.id).setValue(game.toDictionary) { (error, _) in
            if let error = error {
                completion(error)
            } else {
                
            }
        }
    }
}





