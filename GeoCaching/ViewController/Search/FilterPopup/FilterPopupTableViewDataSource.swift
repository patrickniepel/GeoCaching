//
//  FilterPopupViewTableViewDataSource.swift
//  GeoCaching
//
//  Created by Philipp on 16.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class FilterPopupTableViewDataSource: NSObject, UITableViewDataSource {
    
    var filter = ["Top Rated", "Distance", "Duration", "Number of stations", "Lokal", "Routes of friends"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchIdentifiers.filterPopupCell.identifier)!
        cell.isSelected = false
        cell.textLabel?.text = SearchPopupFilter(rawValue: indexPath.row)?.filter
        return cell
    }
    

}
