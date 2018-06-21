//
//  CardCollectionViewDataSource.swift
//  GeoCaching
//
//  Created by Philipp on 09.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class CardCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var games = GameDownloadController().getAllGames()
    var exampleArray = [CardCollectionViewModel]()
    
    init(games: [Game]) {
        self.games = games
        for game in games {
            let readableDistance = RouteController().readableValue(forDistance: game.length)
            let readableTime = RouteController().readableValue(forTravelTime: game.duration)
            let cardModel = CardCollectionViewModel(backgroundImageView: game.image,
                                                    icon1: UIImage(named: "icon_clock"), icon1Text: readableTime,
                                                    icon2: UIImage(named: "icon_walking"), icon2Text: readableDistance,
                                                    cardTitle: game.name,
                                                    cardDescription: game.shortDescription)
            exampleArray.append(cardModel)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        cell.backgroundImageView.image = games[indexPath.row].image
        cell.firstIconImageView.image = UIImage(named: "icon_clock")
        let readableTime = RouteController().readableValue(forTravelTime: games[indexPath.row].duration)
        cell.firstIconLabel.text = readableTime
        cell.secondIconImageView.image = UIImage(named: "icon_walking")
        let readableDistance = RouteController().readableValue(forDistance: games[indexPath.row].length)
        cell.secondIconLabel.text = readableDistance
        cell.cardTitleLabel.text = games[indexPath.row].name
        cell.cardDescriptionLabel.text = games[indexPath.row].shortDescription
        
        return cell
    }
    
    func getGame(atIndexPath indexPath: IndexPath) -> Game {
        return games[indexPath.row]
    }
}
