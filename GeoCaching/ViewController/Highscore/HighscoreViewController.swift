//
//  HighscoreViewController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 18.04.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class HighscoreViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var highscoreTableView: UITableView!
    
    @IBOutlet weak var filterButton: UIBarButtonItem!
    
    var highscoreTableViewDataSource: HighscoreTableViewDataSource!
    private var highscoreTableViewDelegate: HighscoreTableViewDelegate!
    
    let filterWorldButton = UIButton()
    let filterLocaleButton = UIButton()
    let filterFriendsButton = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDesign()
        setupText()
        setupData()
    }
    
    
    // MARK: - Setup
    
    func setupText() {
    }
    
    func setupDesign() {
        highscoreTableView.backgroundColor = AppColor.background
        filterButton.tintColor = AppColor.tint
    }
    
    func setupData() {
        highscoreTableViewDataSource = HighscoreTableViewDataSource()
        highscoreTableViewDelegate = HighscoreTableViewDelegate(viewCtrl: self)
        highscoreTableView.dataSource = highscoreTableViewDataSource
        highscoreTableView.delegate = highscoreTableViewDelegate
        
        filterWorldButton.setImage(UIImage(named: "icon_world"), for: .normal)
        setDesign(forButton: filterWorldButton)
        
        filterLocaleButton.setImage(UIImage(named: "icon_locale"), for: .normal)
        setDesign(forButton: filterLocaleButton)
        
        filterFriendsButton.setImage(UIImage(named: "icon_friends"), for: .normal)
        setDesign(forButton: filterFriendsButton)
        
        filterFriendsButton.addTarget(self, action: #selector(filterButtonAction(_:)), for: .touchUpInside)
        filterWorldButton.addTarget(self, action: #selector(filterButtonAction(_:)), for: .touchUpInside)
        filterLocaleButton.addTarget(self, action: #selector(filterButtonAction(_:)), for: .touchUpInside)
        
        downloadUsers()
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == HighscoreStoryboardSegue.userDetail.identifier {
            guard let selectedUser = sender as? User, let destVCtrl = segue.destination as? ProfileViewController else {
                return
            }
 
            destVCtrl.user = selectedUser
        }
        if segue.identifier == HighscoreStoryboardSegue.segue2FilterPopup.identifier{
            let popoverViewController = segue.destination as! FilterPopupViewController
            popoverViewController.modalPresentationStyle = .popover
            popoverViewController.popoverPresentationController!.delegate = self
            popoverViewController.popoverPresentationController?.backgroundColor = AppColor.tint
            popoverViewController.preferredContentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height*0.3)
            popoverViewController.desitinationHighscore = self
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    
    // MARK: - Helperfunctions
    private func setDesign(forButton button: UIButton) {
//        expendableMenuButton.layer.borderColor = AppColor.tint.cgColor
//        expendableMenuButton.layer.borderWidth = 2.0
    }
    
    @objc private func filterButtonAction(_ sender: UIButton) {
//        if !expendableMenuButton.isRunningAnimation {
//            switch sender {
//            case filterWorldButton: print("world")
//            case filterLocaleButton: print("locale")
//            case filterFriendsButton: print("friends")
//            default: break
//            }
//            expendableMenuButton.toggle(onView: self.view)
//        }
    }
    
    private func downloadUsers(){
        AuthController().fetchAllUser { (downloadedUsers, error) in
            if error != nil{
                print("Something went wrong with downloading users")
            }else{
                if let users = downloadedUsers{
                    self.highscoreTableViewDataSource.data = users
                    self.highscoreTableViewDataSource.data.sort(by: { $0.points > $1.points })
                    self.highscoreTableView.reloadData()
                }
            }
        }
    }
}



// MARK: - IBAction

extension HighscoreViewController {
    @IBAction func menuButtonAction(_ sender: MenuButton) {
        sender.toggle(onView: self.view)
    }
}





