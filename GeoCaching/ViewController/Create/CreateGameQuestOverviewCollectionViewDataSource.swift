//
//  CreateGameQuestOverviewCollectionViewDataSource.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 25.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class CreateGameQuestOverviewCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var quests = DummyContent.sharedInstance.quests
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CreateGameQuestOverviewCollectionViewCell
        
        let quest = getQuest(atIndexPath: indexPath)
        cell.infoLabel.text = "\(quest.id)"
        
        return cell
    }
    
    func getQuest(atIndexPath indexPath: IndexPath) -> Quest {
        return quests[indexPath.row]
    }
}
