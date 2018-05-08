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
    
    var name: String {
        switch self {
        case .textInput: return "Textinput"
        case .fourChoices: return "4 Choices"
        case .date: return "Date"
        case .image: return "Image"
        case .number: return "Number"
        }
    }
}

enum QuestCategory {
    case nature
    case city
    case under10km
    
    var name: String {
        switch self {
        case .nature: return "nature"
        case .city: return "city"
        case .under10km: return "under10km"
        }
    }
}

enum Rank {
    case schnitzler
    case otherRankName
    case guru
    
    static func getRank(forPoints points: Int) -> Rank {
        switch points {
        case 0...999_999: return Rank.schnitzler
        case 1_000_000...99_999_999: return Rank.otherRankName
        default: return Rank.guru
        }
    }
    
    var name: String {
        switch self {
        case .schnitzler: return "Schnitzler"
        case .otherRankName: return "Weitere Namen überlegen"
        case .guru: return "Guru"
        }
    }
}


enum AchivementType {
    case geoSchnitzler
    case noob
    
    static let allAchivementTypes = [AchivementType.geoSchnitzler, .noob]
    
    init?(filename: String) {
        switch filename {
        case "geoSchnitzler.3dModelFileNamePostfix": self = .geoSchnitzler
        case "noob.3dModelFileNamePostfix": self = .noob
        default: return nil
        }
    }
    
    var filename: String {
        switch self {
        case .geoSchnitzler: return "geoSchnitzler.3dModelFileNamePostfix"
        case .noob: return "noob.3dModelFileNamePostfix"
        }
    }
    var title: String {
        switch self {
        case .geoSchnitzler: return "Schnitzel di Schnitzel"
        case .noob: return "Kack Noob!"
        }
    }
    var conditionDescription: String {
        switch self {
        case .geoSchnitzler: return "To earn this achivement you have to lead a highscore."
        case .noob: return "To earn this achivement you have to be you."
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


extension Date {
    var dateDatabaseFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        return dateFormatter.string(from: self)
    }
    
    init?(fromDatabaseFormat databaseString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        if let date = dateFormatter.date(from: databaseString) {
            self = date
        } else {
            return nil
        }
    }
}


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

struct User {
    var id: String
    var username: String
    var userImage: UIImage?
    var userImageFileName: String {
        return id
    }
    var isPresenter: Bool
    var points: Int
    var earnedAchivements: [Achivement] = []
    var rank: Rank {
        return Rank.getRank(forPoints: points)
    }
    var currentLocation: CLLocationCoordinate2D? = nil
    
    init (id: String, username: String, userImage: UIImage?,
          isPresenter: Bool, points: Int, earnedAchivements: [Achivement]) {
        self.id = id
        self.username = username
        self.userImage = userImage
        self.isPresenter = isPresenter
        self.points = points
        self.earnedAchivements = earnedAchivements
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String:Any],
                let username = dict["username"] as? String,
                let isPresenter = dict["isPresenter"] as? Bool,
                let points = dict["points"] as? Int else {
            return nil
        }
        
        if let achievementDictionaries = dict["earnedAchivements"] as? [[String:Any]] {
            var achievements: [Achivement] = []
            for achievementDict in achievementDictionaries {
                if let achievement =  Achivement(dict: achievementDict) {
                    print(achievement)
                    achievements.append(achievement)
                }
            }
            self.earnedAchivements = achievements
        }
        
        self.id = snapshot.key
        self.username = username
        self.isPresenter = isPresenter
        self.points = points
    }
    
    var toDictionary: [String:Any] {
        return [
            "username": username,
            "isPresenter": isPresenter,
            "points": points,
            "earnedAchivements": earnedAchivements.map { $0.toDictionary }
        ]
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
    var id: String
    var name: String
    var shortDescription: String
    var longDescription: String
    var categories: [QuestCategory]
    var duration: Double // in minutes
    var legth: Double // in km
    var image: UIImage?
    var raiting: Int
    var quests: [Quest]
}

struct Quest {
    var answers: [String]
    var correctAnswer: String {
        return answers.first ?? "Error"
    }
    var question: String
    var image: UIImage
    var questionType: QuestionType
    var locationPolygonPoints: [CLLocationCoordinate2D]
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
        let data = description.data(using: .ascii, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        
        if let ciImage = filter?.outputImage {
            let highResolutionCIImageQR = ciImage.transformed(by: CGAffineTransform(scaleX: 20, y: 20))
            return UIImage(ciImage: highResolutionCIImageQR)
        }
        return nil
    }
}

