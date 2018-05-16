//
//  Model.swift
//  GeoTestModel
//
//  Created by Marcel Hagmann on 18.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseDatabase

enum QuestionType {
    case textInput
    case fourChoices
    case date
    case image
    case number
    
    init?(dbName: String) {
        switch dbName {
        case "textinput": self = .textInput
        case "four_choices": self = .fourChoices
        case "date": self = .date
        case "image": self = .image
        case "number": self = .number
        default: return nil
        }
    }
    
    var name: String {
        switch self {
        case .textInput: return "Textinput"
        case .fourChoices: return "4 Choices"
        case .date: return "Date"
        case .image: return "Image"
        case .number: return "Number"
        }
    }
    
    var dbName: String {
        switch self {
        case .textInput: return "textinput"
        case .fourChoices: return "four_choices"
        case .date: return "date"
        case .image: return "image"
        case .number: return "number"
        }
    }
}

enum QuestCategory {
    case nature
    case city
    case under10km
    
    init?(dbName: String) {
        switch dbName {
        case "nature": self = .nature
        case "city": self = .city
        case "under10km": self = .under10km
        default: return nil
        }
    }
    
    var name: String {
        switch self {
        case .nature: return "nature"
        case .city: return "city"
        case .under10km: return "under10km"
        }
    }
    
    var dbName: String {
        switch self {
        case .nature: return "nature"
        case .city: return "city"
        case .under10km: return "under10km"
        }
    }
}





enum Filter {
    case friends
    case locale
    case global
    
    var imageName: String {
        switch self {
        case .friends: return "icon_friends"
        case .locale: return "icon_locale"
        case .global: return "icon_global"
        }
    }
}









protocol Highscore {
    var userID: String { get set }
}

struct UserHighscore: Highscore {
    var userID: String
    var points: Int
}

struct GameHighscore: Highscore {
    var userID: String
    var duration: Int
    var kilometres: Double
}



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


struct Quest {
    
    init(answers: [String], question: String, image: UIImage?, questionType: QuestionType, locationPolygonPoints: [CLLocationCoordinate2D]) {
        self.id = UUID().uuidString
        self.answers = answers
        self.question = question
        self.image = image
        self.questionType = questionType
        self.locationPolygonPoints = locationPolygonPoints
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String:Any],
            let id = dict["id"] as? String,
            let answers = dict["answers"] as? [String],
            let question = dict["question"] as? String,
            let questionTypeDBName = dict["questionType"] as? String,
            let questionType = QuestionType(dbName: questionTypeDBName),
            let locationPolygonPoints = dict["locationPolygonPoints"] as? [CLLocationCoordinate2D] else {
                return nil
        }
        
        self.id = id
        self.answers = answers
        self.question = question
        self.questionType = questionType
        self.locationPolygonPoints = locationPolygonPoints
    }
    
    var id: String
    var answers: [String]
    var correctAnswer: String {
        return answers.first ?? "Error"
    }
    var question: String
    var image: UIImage?
    var questionType: QuestionType
    var locationPolygonPoints: [CLLocationCoordinate2D]
    var toDictionary: [String:Any] {
        return [
            "answers": answers,
            "correctAnswer": correctAnswer,
            "question": question,
            "questionType": questionType.dbName,
            "locationPolygonPoints": locationPolygonPoints.map { "\($0.latitude);\($0.latitude)" }
        ]
    }
}

func isPoint(_ point: CLLocationCoordinate2D, locatedIn polygon: [CLLocationCoordinate2D]) -> Bool {
    return false
}

struct Voucher {
    var locationName: String
    var location: CLLocationCoordinate2D
    var description: String
    var discount: Int
    var qrCode: UIImage? {
        return description.qrCode(withScaleFactor: 20)
    }
}


