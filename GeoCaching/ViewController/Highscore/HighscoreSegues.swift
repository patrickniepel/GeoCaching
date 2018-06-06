//
//  ProfileSegues.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 09.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import Foundation

enum HighscoreStoryboardSegue {
    case userDetail
    case segue2FilterPopup
    
    
    var identifier: String {
        switch self {
        case .userDetail: return "highscoreSegueUserdetail"
        case .segue2FilterPopup: return "FilterPopup"
        }
    }
}
