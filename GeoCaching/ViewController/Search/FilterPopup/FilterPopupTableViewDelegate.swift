//
//  FilterPopupTableViewDelegate.swift
//  GeoCaching
//
//  Created by Philipp on 16.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class FilterPopupTableViewDelegate: NSObject, UITableViewDelegate {
    
    var currentSelected = 0
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dataSource = tableView.dataSource as! FilterPopupTableViewDataSource
        tableView.deselectRow(at: indexPath, animated: true)
        dataSource.toggleAccessory(indexPath.row)
        tableView.reloadData()
        
    }
}
