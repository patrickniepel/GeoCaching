//
//  HighscoreTableViewDelegate.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 09.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class HighscoreTableViewDelegate: NSObject, UITableViewDelegate {
    private weak var viewCtrl: UIViewController?
    
    init(viewCtrl: UIViewController) {
        self.viewCtrl = viewCtrl
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let dSource = tableView.dataSource as? HighscoreTableViewDataSource {
            let selectedUser = dSource.getUser(atIndexPath: indexPath)
            
            let identifier = HighscoreStoryboardSegue.userDetail.identifier
            viewCtrl?.performSegue(withIdentifier: identifier, sender: selectedUser)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}
