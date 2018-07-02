//
//  CreateGameQuestOverviewCollectionViewDataSource.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 25.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class CreateGameQuestOverviewCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var quests: [Quest] = [] //DummyContent.sharedInstance.quests
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CreateGameQuestOverviewCollectionViewCell
        
        let quest = getQuest(atIndexPath: indexPath)
        cell.infoLabel.text = "\(quest.question)"
        cell.questImageView.image = quest.image
        
        cell.cellBackgroundView.layer.cornerRadius = 10
        cell.cellBackgroundView.backgroundColor = AppColor.backgroundLighter2
        cell.infoLabel.textColor = AppColor.text
        
        return cell
    }
    
    func getQuest(atIndexPath indexPath: IndexPath) -> Quest {
        return quests[indexPath.row]
    }
}

class CreateGameQuestOverviewCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    private weak var vCtrl: UIViewController!
    
    init(vCtrl: UIViewController) {
        self.vCtrl = vCtrl
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let dSource = collectionView.dataSource as? CreateGameQuestOverviewCollectionViewDataSource {
            let selectedQuest = dSource.getQuest(atIndexPath: indexPath)
            vCtrl.performSegue(withIdentifier: CreateStoryboardSegue.editQuest.identifier, sender: selectedQuest)
        }
    }
}
