//
//  Achivement.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 08.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import Foundation

struct Achivement {
    var earnedDate: Date?
    var type: AchivementType
    
    init?(dict: [String:Any]) {
        guard let earnedDateAsString = dict["earnedDate"] as? String,
            let earnedDate = Date(fromDatabaseFormat: earnedDateAsString),
            let achivementTypeFilename = dict["achivementType"] as? String,
            let achivementType = AchivementType(filename: achivementTypeFilename) else {
                return nil
        }
        
        self.earnedDate = earnedDate
        self.type = achivementType
    }
    
    init(type: AchivementType) {
        self.type = type
        self.earnedDate = Date()
    }
    
    var toDictionary: [String:Any] {
        let dateAsString = earnedDate == nil ? "nil" : "\(earnedDate!.dateDatabaseFormat)"
        return [
            "earnedDate": dateAsString,
            "achivementType": type.filename
        ]
    }
}
