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
    }
    
    func setupData() {
        highscoreTableViewDataSource = HighscoreTableViewDataSource()
        highscoreTableViewDelegate = HighscoreTableViewDelegate(viewCtrl: self)
        highscoreTableView.dataSource = highscoreTableViewDataSource
        highscoreTableView.delegate = highscoreTableViewDelegate
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

}
