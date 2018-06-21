//
//  GameSegues.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 20.06.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import Foundation

enum GameSegues {
    case displayQuestion
    
    var identifier: String {
        switch self {
        case .displayQuestion: return "gameSegueDisplayQuestion"
        }
    }
}
