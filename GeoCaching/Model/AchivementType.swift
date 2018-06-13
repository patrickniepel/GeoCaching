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
        let postfix = ".dae"
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
        let postfix = ".dae"
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
        case .firstChallengeAccepted: return "First Challenge Accepted"
        case .firstChallengeCompleted: return "First Challenge Completed"
        case .firstOfAll: return "First Of All"
        case .creator: return "Creator"
        case .trendsetter: return "Trendsetter"
        case .supporter: return "Supporter"
        case .becomeMmoderator: return "Moderator"
        case .move5km: return "Move 5km"
        case .withoutMistakes: return "No Mistakes"
        case .noob: return "Noob"
        }
    }
    var conditionDescription: String {
        switch self {
        case .firstChallengeAccepted: return "Participate At A Schnitzlr-Hunt."
        case .firstChallengeCompleted: return "Complete Your First Schnitzlr-Hunt."
        case .firstOfAll: return "Be The Fastest To Complete A Schnitzlr-Hunt."
        case .creator: return "Create Your First Schnitzlr-Hunt."
        case .trendsetter: return "Invite A Friend."
        case .supporter: return "Participate At The Same Schnitlr-Hunt As One Of Your Friends."
        case .becomeMmoderator: return "Become A Moderator."
        case .move5km: return "Walk 5km While Using The App."
        case .withoutMistakes: return "Complete A Schnitzlr-Hunt Without Any Mistakes."
        case .noob: return "Be Yourself."
        }
    }
}
