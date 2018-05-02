//
//  Controller.swift
//  GeoTestModel
//
//  Created by Marcel Hagmann on 18.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import UIKit
import CoreLocation


// MARK: - Profile

protocol ProfileDelegate {
    func downloaded(currentUserProfile: User)
    func downloaded(userProfile: User)
    func downloaded(userProfileImage: UIImage?)
}

struct ProfileController {
    
    var delegate: ProfileDelegate?
    
    func downloadCurrentUserProfile() {
        let currentUser = User(id: "123",
                               username: "Marceeelll",
                               userImage: nil,
                               isPresenter: false,
                               points: 1_233_321,
                               earnedAchivements: [])
        delegate?.downloaded(currentUserProfile: currentUser)
    }
    
    func downloadUserProfile(withUserID userID: String) {
        let otherUser = User(id: "3222",
                             username: "Other Username",
                             userImage: nil,
                             isPresenter: false,
                             points: 233_321,
                             earnedAchivements: [])
        delegate?.downloaded(userProfile: otherUser)
    }
    
    func downloadUserProfileImage(forUserID userID: String) {
        let downloadedImage = UIImage(named: "profileImage")
        delegate?.downloaded(userProfileImage: downloadedImage)
    }
}


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
    
    func downloadHighscore(withFilter filter: Filter, userWhoRequest user: User) {
        let highscoreUser = UserHighscore(userID: "123", points: 1_234_111)
        let highscores = [highscoreUser]
        delegate?.downloaded(gameHighscores: highscores)
    }
}


// MARK: - Auth

protocol AuthDelegate {
    func registered(user: User)
    func loggedIn(user: User)
}

struct AuthController {
    var delegate: AuthDelegate?
    
    func register(withEmail email: String, andPassword password: String) {
        let user = User(id: "123",
                        username: "Marceeelll",
                        userImage: nil,
                        isPresenter: false,
                        points: 1_233_321,
                        earnedAchivements: [])
        delegate?.registered(user: user)
    }
    
    func login(withEmail email: String, andPassword password: String) {
        let user = User(id: "123",
                        username: "Marceeelll",
                        userImage: nil,
                        isPresenter: false,
                        points: 1_233_321,
                        earnedAchivements: [])
        delegate?.loggedIn(user: user)
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
        let game = Game(id: "1111",
                        name: "Hof Adventure",
                        shortDescription: "Die besten Plätze rund um Hof",
                        longDescription: "Hier steht die lange Beschreibung",
                        categories: [.nature, .city, .under10km],
                        duration: 97,
                        legth: 2.7,
                        image: nil, raiting: 21)
        delegate?.downloaded(games: [game])
    }
}


// MARK: - Create Game

struct CreateGameController {
}



