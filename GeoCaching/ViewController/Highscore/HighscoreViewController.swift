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
    @IBOutlet weak var expendableMenuButton: MenuButton!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    
    private var highscoreTableViewDataSource: HighscoreTableViewDataSource!
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
        
        expendableMenuButton.setImage(UIImage(named: "filter"), for: .normal)
        expendableMenuButton.tintColor = AppColor.tint
        expendableMenuButton.backgroundColor = AppColor.background
        expendableMenuButton.setTitleColor(AppColor.tint, for: .normal)
        expendableMenuButton.layer.cornerRadius = expendableMenuButton.frame.width/2
        expendableMenuButton.expandingDirection = .degree(221)
        setDesign(forButton: expendableMenuButton)
        
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
        
        expendableMenuButton.expandingViewsMenu = [filterWorldButton, filterLocaleButton, filterFriendsButton]
        
        filterFriendsButton.addTarget(self, action: #selector(filterButtonAction(_:)), for: .touchUpInside)
        filterWorldButton.addTarget(self, action: #selector(filterButtonAction(_:)), for: .touchUpInside)
        filterLocaleButton.addTarget(self, action: #selector(filterButtonAction(_:)), for: .touchUpInside)
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
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    
    // MARK: - Helperfunctions
    private func setDesign(forButton button: UIButton) {
        expendableMenuButton.layer.borderColor = AppColor.tint.cgColor
        expendableMenuButton.layer.borderWidth = 2.0
    }
    
    @objc private func filterButtonAction(_ sender: UIButton) {
        if !expendableMenuButton.isRunningAnimation {
            switch sender {
            case filterWorldButton: print("world")
            case filterLocaleButton: print("locale")
            case filterFriendsButton: print("friends")
            default: break
            }
            expendableMenuButton.toggle(onView: self.view)
        }
    }
}


// MARK: - IBAction

extension HighscoreViewController {
    @IBAction func menuButtonAction(_ sender: MenuButton) {
        sender.toggle(onView: self.view)
    }
}





