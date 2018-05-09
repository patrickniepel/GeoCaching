//
//  HighscoreViewController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 18.04.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class HighscoreViewController: UIViewController {
    @IBOutlet weak var highscoreTableView: UITableView!
    @IBOutlet weak var expendableMenuButton: MenuButton!
    
    private var highscoreTableViewDataSource: HighscoreTableViewDataSource!
    private var highscoreTableViewDelegate: HighscoreTableViewDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDesign()
        setupText()
        setupData()
    }
    
    
    // MARK: - Setup
    
    func setupText() {
        self.title = "Highscore"
    }
    
    func setupDesign() {
        highscoreTableView.backgroundColor = AppColor.background
        
        expendableMenuButton.backgroundColor = AppColor.background
        expendableMenuButton.setTitleColor(AppColor.tint, for: .normal)
        expendableMenuButton.layer.cornerRadius = expendableMenuButton.frame.width/2
        expendableMenuButton.expandingDirection = .degree(221)
        setDesign(forButton: expendableMenuButton)
    }
    
    func setupData() {
        highscoreTableViewDataSource = HighscoreTableViewDataSource()
        highscoreTableViewDelegate = HighscoreTableViewDelegate(viewCtrl: self)
        highscoreTableView.dataSource = highscoreTableViewDataSource
        highscoreTableView.delegate = highscoreTableViewDelegate
        
        let button1 = UIButton()
        button1.setImage(UIImage(named: "icon_world"), for: .normal)
        setDesign(forButton: button1)
        
        let button2 = UIButton()
        button2.setImage(UIImage(named: "icon_locale"), for: .normal)
        setDesign(forButton: button2)
        
        let button3 = UIButton()
        button3.setImage(UIImage(named: "icon_friends"), for: .normal)
        setDesign(forButton: button3)
        
        expendableMenuButton.expandingViewsMenu = [button1, button2, button3]
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == HighscoreStoryboardSegue.userDetail.identifier {
            guard let selectedUser = sender as? User, let destVCtrl = segue.destination as? ProfileViewController else {
                return
            }
            
            destVCtrl.user = selectedUser
        }
    }

    @IBAction func menuButtonAction(_ sender: MenuButton) {
        sender.toggle(onView: self.view)
    }
    
    // MARK: - Helperfunctions
    private func setDesign(forButton button: UIButton) {
        expendableMenuButton.layer.borderColor = AppColor.tint.cgColor
        expendableMenuButton.layer.borderWidth = 2.0
    }
}


// MARK: - IBAction

extension HighscoreViewController {
    
}





