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


