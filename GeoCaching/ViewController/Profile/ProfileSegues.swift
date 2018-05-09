//
//  ProfileSegues.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 08.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import Foundation

enum ProfileStoryboardSegue {
    case createdRoutes
    case history
    case friends
    
    case achievementDetail
    
    var identifier: String {
        switch self {
        case .createdRoutes: return "profileSegueCreatedRoutes"
        case .history: return "profileSegueHistory"
        case .friends: return "profileSegueFriends"
        case .achievementDetail: return "profileSegueAchievementDetail"
        }
    }
}
