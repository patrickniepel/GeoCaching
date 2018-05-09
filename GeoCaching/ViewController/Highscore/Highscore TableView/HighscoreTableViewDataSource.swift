//
//  HighscoreTableViewDataSource.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 09.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class HighscoreTableViewDataSource: NSObject, UITableViewDataSource {
    private var data: [User] = DummyContent.sharedInstance.users
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HighscoreTableViewCell
        cell.set(tag: indexPath.row)
        cell.accessoryView?.tintColor = AppColor.tint
        cell.backgroundColor = AppColor.background
        
        cell.usernameLabel.textColor = AppColor.text
        cell.titleLabel.textColor = AppColor.text
        cell.pointsLabel.textColor = AppColor.text
        cell.rankLabel.textColor = AppColor.text
        
        
        let user = getUser(atIndexPath: indexPath)
        cell.profileImageView.image = user.userImage
        cell.usernameLabel.text = user.username
        cell.titleLabel.text = "(\(user.rank.name))"
        cell.pointsLabel.text = user.formattedPoints
        cell.rankLabel.text = "\(indexPath.row + 1)"
        
        return cell
    }
    
    func getUser(atIndexPath indexPath: IndexPath) -> User {
        return data[indexPath.row]
    }
}
