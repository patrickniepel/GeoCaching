//
//  ProfileAchievementsCollectionViewDataSource.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 08.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class ProfileAchievementsCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    private var achievements: [Achivement] = []
    
    init(achievements: [Achivement]) {
        self.achievements = achievements
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return achievements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProfileAchievementsCollectionViewCell
        
        let achievement = getAchievement(atIndexPath: indexPath)
        cell.achievementImageView.image = UIImage(named: "gary")
        cell.setup()
        
        return cell
    }
    
    func getAchievement(atIndexPath indexPath: IndexPath) -> Achivement {
        return achievements[indexPath.row]
    }
}
