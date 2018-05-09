//
//  ProfileViewController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 18.04.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var achievementsTitleLabel: UILabel!
    
    @IBOutlet weak var profileActionsTableView: UITableView!
    @IBOutlet weak var achievementsCollectionView: UICollectionView!
    
    private var user = User(id: "the id", username: "GaryVee", userImage: UIImage(named: "gary")!,
                            isPresenter: false, points: 2_364_477,
                            earnedAchivements: [Achivement(type: AchivementType.geoSchnitzler),
                                                Achivement(type: AchivementType.noob),
                                                Achivement(type: AchivementType.noob),
                                                Achivement(type: AchivementType.noob),
                                                Achivement(type: AchivementType.noob)])
    
    private var actionTableViewDataSource: ProfileActionTableViewDataSource!
    private var actionTableViewDelegate: ProfileActionTableViewDelegate!
    
    private var achievementsCollectionViewDataSource: ProfileAchievementsCollectionViewDataSource!
    private var achievementsCollectionViewDelegate: ProfileAchievementsCollectionViewDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDesign()
        setupText()
        setupData()
    }
    
    
    // MARK: - Setup
    
    func setupText() {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = "."
        numberFormatter.numberStyle = .decimal
        let points = NSNumber(value: user.points)
        pointsLabel.text = "\(numberFormatter.string(from: points) ?? "0") points"
        
        fullnameLabel.text = "\(user.username)"
        
        titleLabel.text = "(\(Rank.getRank(forPoints: user.points)))"
    }
    
    func setupDesign() {
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2.0
        profileImageView.layer.borderColor = AppColor.tint.cgColor
        profileImageView.layer.borderWidth = 5.0
    }
    
    func setupData() {
        actionTableViewDataSource = ProfileActionTableViewDataSource()
        actionTableViewDelegate = ProfileActionTableViewDelegate(viewCtrl: self)
        profileActionsTableView.dataSource = actionTableViewDataSource
        profileActionsTableView.delegate = actionTableViewDelegate
        
        achievementsCollectionViewDataSource = ProfileAchievementsCollectionViewDataSource(achievements: user.earnedAchivements)
        achievementsCollectionViewDelegate = ProfileAchievementsCollectionViewDelegate(viewCtrl: self)
        achievementsCollectionView.dataSource = achievementsCollectionViewDataSource
        achievementsCollectionView.delegate = achievementsCollectionViewDelegate
    }
    
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: implement
    }
}
