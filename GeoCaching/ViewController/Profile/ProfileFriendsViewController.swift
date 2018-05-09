//
//  ProfileFriendsViewController.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 09.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class ProfileFriendsViewController: UIViewController {
    @IBOutlet weak var friendsTableView: UITableView!
    
    private var friendsTableViewDataSource: ProfileFriendsTableViewDataSource!
    private var friendsTableViewDelegate: ProfileFriendsTableViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDesign()
        setupText()
        setupData()
    }
    
    
    // MARK: - Setup
    
    func setupText() {
        self.title = "Friends"
    }
    
    func setupDesign() {
        self.view.backgroundColor = AppColor.background
        
        friendsTableView.backgroundColor = AppColor.background
    }
    
    func setupData() {
        friendsTableViewDataSource = ProfileFriendsTableViewDataSource()
        friendsTableViewDelegate = ProfileFriendsTableViewDelegate()
        friendsTableView.dataSource = friendsTableViewDataSource
        friendsTableView.delegate = friendsTableViewDelegate
    }
}
