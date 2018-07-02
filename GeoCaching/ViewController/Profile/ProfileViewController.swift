//
//  ProfileViewController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 18.04.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit
import CoreLocation

class ProfileViewController: UIViewController {
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var profileImageView: UIProfileImageView!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var achievementsTitleLabel: UILabel!
    
    @IBOutlet weak var profileActionsTableView: UITableView!
    @IBOutlet weak var achievementsCollectionView: UICollectionView!
    
    var user: User?
    var authController : AuthController!
    
    private var actionTableViewDataSource: ProfileActionTableViewDataSource!
    private var actionTableViewDelegate: ProfileActionTableViewDelegate!
    
    private var achievementsCollectionViewDataSource: ProfileAchievementsCollectionViewDataSource!
    private var achievementsCollectionViewDelegate: ProfileAchievementsCollectionViewDelegate!
    
    private var profileCtrl = ProfileController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Test", style: .done, target: self, action: #selector(theeesTest))
        
        setupDesign()
        setupText()
        setupData()
    }
    
    @objc func theeesTest() {
        print("    --- 123")
        profileCtrl.updateUserProfile(newAchivementType: .firstChallengeAccepted)
    }
    
    
    // MARK: - Setup
    
    func setupText() {
        self.title = "Profile"
    }
    
    func setupDesign() {
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2.0
        profileImageView.layer.borderColor = AppColor.tint.cgColor
        profileImageView.layer.borderWidth = 5.0
        self.view.backgroundColor = AppColor.background
        pointsLabel.textColor = AppColor.text
        fullnameLabel.textColor = AppColor.text
        titleLabel.textColor = AppColor.text
        achievementsTitleLabel.textColor = AppColor.text
        
        profileActionsTableView.backgroundColor = UIColor.clear
        achievementsCollectionView.backgroundColor = UIColor.clear
        
        if user?.id == UserSingleton.sharedInstance.currentUser?.id {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logoutAction(_:)))
            navigationItem.rightBarButtonItem?.tintColor = AppColor.tint
        }
    }
    
    func setupData() {
        actionTableViewDataSource = ProfileActionTableViewDataSource()
        actionTableViewDelegate = ProfileActionTableViewDelegate(viewCtrl: self)
        profileActionsTableView.dataSource = actionTableViewDataSource
        profileActionsTableView.delegate = actionTableViewDelegate
        
        achievementsCollectionViewDelegate = ProfileAchievementsCollectionViewDelegate(viewCtrl: self)
        achievementsCollectionView.delegate = achievementsCollectionViewDelegate
        
        authController = AuthController()
        
        if let user = user {
            self.setup(user: user)
            
            self.achievementsCollectionViewDataSource = ProfileAchievementsCollectionViewDataSource(achievements: user.earnedAchivements)
            self.achievementsCollectionView.dataSource = self.achievementsCollectionViewDataSource
            self.achievementsCollectionView.reloadData()
        }
    }
    
    private func setup(user: User) {
        pointsLabel.text = user.formattedPoints
        fullnameLabel.text = "\(user.username)"
        titleLabel.text = "(\(Rank.getRank(forPoints: user.points)))"
        
        if let userImage = user.userImage {
            profileImageView.image = userImage
        }else{
            profileImageView.image = UIImage(named: "Schnitzlr_Boar")
        }
    }
    
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: implement
        if segue.identifier == ProfileStoryboardSegue.achievementDetail.identifier {
            guard let selectedAchivement = sender as? Achivement, let destVCtrl = segue.destination as? ProfileAchievementDetailViewController else {
                return
            }
            destVCtrl.achievement = selectedAchivement
        }
    }
}


// MARK: - Actions
extension ProfileViewController {
    @objc func logoutAction(_ sender: UIBarButtonItem) {
        
        
        logoutDialog(title: "Logout", message: "Are you sure?", authCtrl: authController)
        
//        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
//        let loginViewCtrl = loginStoryboard.instantiateViewController(withIdentifier: "storyboardID_login_vc") as! LoginViewController
//        present(loginViewCtrl, animated: false, completion: nil)
    }
}
