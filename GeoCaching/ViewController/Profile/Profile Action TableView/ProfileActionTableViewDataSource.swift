//
//  ProfileActionTableViewDataSource.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 08.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class ProfileActionTableViewDataSource: NSObject, UITableViewDataSource {
    let data = [ProfileActionEntry(name: "Erstellte Strecken", icon: UIImage(named: "icon_create"), segue: .createdRoutes),
                ProfileActionEntry(name: "Verlauf", icon: UIImage(named: "icon_history"), segue: .history),
                ProfileActionEntry(name: "Freunde", icon: UIImage(named: "icon_friends"), segue: .friends)]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.tintColor = UIColor.green
        cell.accessoryView?.tintColor = UIColor.red
        cell.backgroundColor = AppColor.background
        cell.textLabel?.textColor = AppColor.text
        
        let entry = getData(atIndexPath: indexPath)
        cell.textLabel?.text = entry.name
        cell.imageView?.image = entry.icon
        
        return cell
    }
    
    func getData(atIndexPath indexPath: IndexPath) -> ProfileActionEntry {
        return data[indexPath.row]
    }
}
