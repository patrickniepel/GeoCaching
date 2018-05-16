//
//  ProfileAchievementsCollectionViewCell.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 08.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class ProfileAchievementsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var achievementImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        achievementImageView.image = #imageLiteral(resourceName: "achievementTest")
    }
}
