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
    
    init(name: String, shortDescription: String, longDescription: String, categories: [QuestCategory], duration: Double, length: Double, image: UIImage?, quests: [Quest]) {
        self.id = UUID().uuidString
        self.name = name
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.categories = categories
        self.duration = duration
        self.length = length
        self.image = image
        self.ratings = []
        self.quests = quests
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String:Any],
            let name = dict["name"] as? String,
            let shortDescription = dict["shortDescription"] as? String,
            let longDescription = dict["longDescription"] as? String,
            let categorieNames = dict["categories"] as? [String],
            let duration = dict["duration"] as? Double,
            let length = dict["length"] as? Double,
            let questIDs = dict["quests"] as? [String] else {
                return nil
        }
        
        let ratings = dict["ratings"] as? [Int] ?? []
        
        let categories = categorieNames.compactMap { QuestCategory(dbName: $0) }
        
        self.id = snapshot.key
        self.name = name
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.categories = categories
        self.duration = duration
        self.length = length
        self.ratings = ratings
        self.questIDs = questIDs
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
    var rating: Int {
        if ratings.count == 0 {
            return 0
        }
        return ratings.reduce(0) { $0 + $1 } / ratings.count
    }
    var quests: [Quest]
    var ratings: [Int]
    var questIDs: [String] = []
    var toDictionary: [String:Any] {
        return [
            "name": name,
            "shortDescription": shortDescription,
            "longDescription": longDescription,
            "categories": categories.map { $0.dbName },
            "duration": duration,
            "length": length,
            "ratings": ratings,
            "quests": quests.map { $0.id }
        ]
    }
}
