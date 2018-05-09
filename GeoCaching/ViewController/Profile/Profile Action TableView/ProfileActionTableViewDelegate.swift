//
//  ProfileActionTableViewDelegate.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 08.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class ProfileActionTableViewDelegate: NSObject, UITableViewDelegate {
    private weak var viewCtrl: UIViewController?
    
    init(viewCtrl: UIViewController) {
        self.viewCtrl = viewCtrl
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let dSource = tableView.dataSource as? ProfileActionTableViewDataSource {
            let entry = dSource.getData(atIndexPath: indexPath)
            viewCtrl?.performSegue(withIdentifier: entry.segue.identifier, sender: nil)
        }
    }
}
