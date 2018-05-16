//
//  Controller.swift
//  GeoTestModel
//
//  Created by Marcel Hagmann on 18.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseAuth
import FirebaseDatabase





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


// MARK: - Permission

struct PermissionController {
    func requestLocationTracking() {
        let locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
    }
}


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


// MARK: - Create Game

struct CreateGameController {
}



