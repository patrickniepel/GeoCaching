//
//  AchivementType.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 08.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import Foundation

enum AchivementType {
    case firstChallengeAccepted
    case firstChallengeCompleted
    case firstOfAll
    case creator
    case trendsetter
    case supporter
    case becomeMmoderator
    case move5km
    case withoutMistakes
    case noob
    
    static let allAchivementTypes = [AchivementType.firstChallengeAccepted, .firstChallengeCompleted, .firstOfAll,
                                     .creator, .trendsetter, .supporter, .becomeMmoderator, .move5km, .withoutMistakes, .noob]
    
    init?(filename: String) {
        let postfix = ".3dModelFileNamePostfix"
        switch filename {
        case "firstChallengeAccepted\(postfix)": self = .firstChallengeAccepted
        case "firstChallengeCompleted\(postfix)": self = .firstChallengeCompleted
        case "firstOfAll\(postfix)": self = .firstOfAll
        case "creator\(postfix)": self = .creator
        case "trendsetter\(postfix)": self = .trendsetter
        case "supporter\(postfix)": self = .supporter
        case "becomeMmoderator\(postfix)": self = .becomeMmoderator
        case "move5km\(postfix)": self = .move5km
        case "withoutMistakes\(postfix)": self = .withoutMistakes
        default: self = .noob
        }
    }
    
    var filename: String {
        let postfix = ".3dModelFileNamePostfix"
        switch self {
        case .firstChallengeAccepted: return "firstChallengeAccepted\(postfix)"
        case .firstChallengeCompleted: return "firstChallengeCompleted\(postfix)"
        case .firstOfAll: return "firstOfAll\(postfix)"
        case .creator: return "creator\(postfix)"
        case .trendsetter: return "trendsetter\(postfix)"
        case .supporter: return "supporter\(postfix)"
        case .becomeMmoderator: return "becomeMmoderator\(postfix)"
        case .move5km: return "move5km\(postfix)"
        case .withoutMistakes: return "withoutMistakes\(postfix)"
        case .noob: return "noob\(postfix)"
        }
    }
    var title: String {
        switch self {
        case .firstChallengeAccepted: return "firstChallengeAccepted"
        case .firstChallengeCompleted: return "firstChallengeCompleted"
        case .firstOfAll: return "firstOfAll"
        case .creator: return "creator"
        case .trendsetter: return "trendsetter"
        case .supporter: return "supporter"
        case .becomeMmoderator: return "becomeMmoderator"
        case .move5km: return "move5km"
        case .withoutMistakes: return "withoutMistakes"
        case .noob: return "noob"
        }
    }
    var conditionDescription: String {
        switch self {
        case .firstChallengeAccepted: return "Nehme an deiner ersten Schnitzeljagd teil."
        case .firstChallengeCompleted: return "Schließe deine erste Schnitzeljagd ab."
        case .firstOfAll: return "Schließe eine Schnitzeljagd als erstes ab."
        case .creator: return "Erstelle deine erste eigene Schnitzeljagd."
        case .trendsetter: return "Lade einen Freund ein."
        case .supporter: return "Nehme an der gleichen Schnitzeljagd teil, wie ein Freund von dir."
        case .becomeMmoderator: return "Werde Moderator."
        case .move5km: return "Bewege dich mit der App 5km."
        case .withoutMistakes: return "Schließe eine Schnitzeljagd ab ohne einen einzigen Fehler zu machen."
        case .noob: return "Sei einfach du selbst."
        }
    }
}
