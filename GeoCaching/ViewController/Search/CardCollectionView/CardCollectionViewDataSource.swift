//
//  CardCollectionViewDataSource.swift
//  GeoCaching
//
//  Created by Philipp on 09.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class CardCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var games = [Game]()
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
        return exampleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        cell.backgroundImageView.image = exampleArray[indexPath.row].backgroundImageView
        cell.firstIconImageView.image = exampleArray[indexPath.row].icon1
        cell.firstIconLabel.text = exampleArray[indexPath.row].icon1Text
        cell.secondIconImageView.image = exampleArray[indexPath.row].icon2
        cell.secondIconLabel.text = exampleArray[indexPath.row].icon2Text
        cell.cardTitleLabel.text = exampleArray[indexPath.row].cardTitle
        cell.cardDescriptionLabel.text = exampleArray[indexPath.row].cardDescription
        
        return cell
    }
    
    func getGame(atIndexPath indexPath: IndexPath) -> Game {
        return games[indexPath.row]
    }
}
