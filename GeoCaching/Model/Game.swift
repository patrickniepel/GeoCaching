//
//  Game.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 06.06.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct Game {
    
    init(name: String, shortDescription: String, longDescription: String, categories: [QuestCategory], duration: Double, length: Double, image: UIImage?, rating: Int, quests: [Quest]) {
        self.id = UUID().uuidString
        self.name = name
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.categories = categories
        self.duration = duration
        self.length = length
        self.image = image
        self.rating = rating
        self.quests = quests
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String:Any],
            let id = dict["id"] as? String,
            let name = dict["name"] as? String,
            let shortDescription = dict["shortDescription"] as? String,
            let longDescription = dict["longDescription"] as? String,
            let categorieNames = dict["categories"] as? [String],
            let duration = dict["duration"] as? Double,
            let length = dict["length"] as? Double,
            let rating = dict["raiting"] as? Int,
            let questIDs = dict["quests"] as? [String] else {
                return nil
        }
        
        let categories = categorieNames.compactMap { QuestCategory(dbName: $0) }
        
        self.id = id
        self.name = name
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.categories = categories
        self.duration = duration
        self.length = length
        self.rating = rating
        self.quests = []
    }
    
    var id: String
    var name: String
    var shortDescription: String
    var longDescription: String
    var categories: [QuestCategory]
    var duration: Double // in minutes
    var length: Double // in km
    var image: UIImage?
    var rating: Int
    var quests: [Quest]
    var questIDs: [String] = []
    var toDictionary: [String:Any] {
        return [
            "name": name,
            "shortDescription": shortDescription,
            "longDescription": longDescription,
            "categories": categories.map { $0.dbName },
            "duration": duration,
            "legth": length,
            "raiting": rating,
            "quests": quests.map { $0.id }
        ]
    }
}
