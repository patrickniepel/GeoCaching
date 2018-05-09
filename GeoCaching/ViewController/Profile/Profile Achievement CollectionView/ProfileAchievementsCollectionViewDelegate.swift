//
//  ProfileAchievementsCollectionViewDelegate.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 08.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class ProfileAchievementsCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    private weak var viewCtrl: UIViewController?
    
    init(viewCtrl: UIViewController) {
        self.viewCtrl = viewCtrl
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if let dSource = collectionView.dataSource as? ProfileAchievementsCollectionViewDataSource {
            let achivement = dSource.getAchievement(atIndexPath: indexPath)
            let achievementDetailIdentifier = ProfileStoryboardSegue.achievementDetail.identifier
            viewCtrl?.performSegue(withIdentifier: achievementDetailIdentifier, sender: achivement)
        }
    }
}
