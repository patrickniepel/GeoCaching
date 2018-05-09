//
//  ProfileFriendsTableViewDataSource.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 09.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class ProfileFriendsTableViewDataSource: NSObject, UITableViewDataSource {
    var data: [User] = [DummyContent.sharedInstance.currentUser]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileFriendsTableViewCell
        cell.accessoryView?.tintColor = AppColor.tint
        cell.backgroundColor = AppColor.background
        
        cell.usernameLabel.textColor = AppColor.text
        cell.titleLabel.textColor = AppColor.text
        cell.pointsLabel.textColor = AppColor.text
        
        
        let user = getUser(atIndexPath: indexPath)
        cell.profileImageView.image = user.userImage
        cell.usernameLabel.attributedText = user.usernameWithOnlineStatus
        cell.titleLabel.text = "(\(user.rank.name))"
        cell.pointsLabel.text = user.formattedPoints
        
        return cell
    }
    
    func getUser(atIndexPath indexPath: IndexPath) -> User {
        return data[indexPath.row]
    }
}
