//
//  GameDetailHighscoreTableViewDataSource.swift
//  GeoCaching
//
//  Created by Philipp on 24.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class GameDetailHighscoreTableViewDataSource: NSObject, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchIdentifiers.gameDetailHighscoreHeaderCell.identifier)!
            cell.textLabel?.text = "Highscore"
            cell.backgroundColor = AppColor.background
            cell.textLabel?.textColor = UIColor.white
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchIdentifiers.gameDetailHighscoreTableViewCell.identifier) as! GameDetailHighscoreTableViewCell
        cell.placeLabel.text = "\(indexPath.row + 1)."
        cell.userImage.image = UIImage(named: "yoga")
        cell.userName.text = "Username"
        cell.userDetails.text = "Some Backend Data"
        cell.backgroundColor = AppColor.background
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    

}
