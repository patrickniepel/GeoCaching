//
//  HighscoreController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 06.06.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

// MARK: - Highscore

protocol HighscoreDelegate {
    func downloaded(gameHighscores: [GameHighscore])
    func downloaded(gameHighscores: [UserHighscore])
}

struct HighscoreController {
    
    var delegate: HighscoreDelegate?
    
    func downloadHighscores(forGameID gameID: String) {
        let highscoreUser = GameHighscore(userID: "123", duration: 97, kilometres: 2.4)
        let highscores = [highscoreUser]
        delegate?.downloaded(gameHighscores: highscores)
    }
    
    func downloadHighscores(withFilter filter: Filter, userWhoRequest user: User) {
        let highscoreUser = UserHighscore(userID: "123", points: 1_234_111)
        let highscores = [highscoreUser]
        delegate?.downloaded(gameHighscores: highscores)
    }
}
