//
//  GameController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 06.06.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

// MARK: - Game

protocol GameDelegate {
    func downloaded(games: [Game])
}

struct GameController {
    
    var delegate: GameDelegate?
    
    func downloadGames(withFilter filter: Filter, userWhoRequest user: User) {
        let game = Game(name: "Hof Adventure",
                        shortDescription: "Die besten Plätze rund um Hof",
                        longDescription: "Hier steht die lange Beschreibung",
                        categories: [.nature, .city, .under10km],
                        duration: 97, length: 2.7,
                        image: nil,
                        rating: 21, quests: [])
        delegate?.downloaded(games: [game])
    }
}
