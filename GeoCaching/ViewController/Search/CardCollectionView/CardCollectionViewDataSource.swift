//
//  CardCollectionViewDataSource.swift
//  GeoCaching
//
//  Created by Philipp on 09.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class CardCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var exampleArray : [CardCollectionViewModel] = [CardCollectionViewModel(backgroundImageView: UIImage(named: "yoga"), icon1: UIImage(named: "icon_clock"),icon1Text: "1h 27 min",icon2: UIImage(named: "icon_walking"), icon2Text: "2.82 km", cardTitle: "Dies ist der beste Titel", cardDescription: "Und dies die beste Beschreibung")]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        addExampleModels()
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

    
    func addExampleModels(){
        for _ in 0..<5 {
            exampleArray.append(CardCollectionViewModel(backgroundImageView: UIImage(named: "yoga"), icon1: UIImage(named: "icon_clock"),icon1Text: "1h 27 min",icon2: UIImage(named: "icon_walking"), icon2Text: "2.82 km", cardTitle: "Dies ist der beste Titel", cardDescription: "Und dies die beste Beschreibung"))
        }
    }
    

}
