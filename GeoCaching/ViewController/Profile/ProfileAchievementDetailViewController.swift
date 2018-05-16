//
//  ProfileAchievementDetailViewController.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 09.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit
import SceneKit

class ProfileAchievementDetailViewController: UIViewController {
    @IBOutlet weak var achievementImageView: UIImageView!
    @IBOutlet weak var achievementNameLabel: UILabel!
    @IBOutlet weak var achievementDescriptionLabel: UILabel!
    
    var achievement: Achivement!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = achievement.type.title
        
        setupDesign()
        setupText()
        setupData()
    }
    
    
    // MARK: - Setup
    
    private func setupScene() {
    
    }
    
    func setupText() {
        achievementNameLabel.text = achievement.type.title
        achievementDescriptionLabel.text = achievement.type.conditionDescription
        //achievementImageView.image = UIImage(named: "gary")
    }
    
    func setupDesign() {
        self.view.backgroundColor = AppColor.background
        achievementNameLabel.textColor = AppColor.text
        achievementDescriptionLabel.textColor = AppColor.text
    }
    
    func setupData() {
    }
}
