//
//  GameError.swift
//  GeoCaching
//
//  Created by Philipp on 13.06.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

enum GameError: Error {
    case failedFetchingGame
    case gameNotFound
    
    var localizedDescription : String{
        switch self {
            case .failedFetchingGame: return "A game error occured."
            case .gameNotFound: return "Game not found."
        }
    }
}
