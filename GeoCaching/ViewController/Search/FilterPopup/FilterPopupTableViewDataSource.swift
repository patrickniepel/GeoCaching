//
//  FilterPopupViewTableViewDataSource.swift
//  GeoCaching
//
//  Created by Philipp on 16.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class FilterPopupTableViewDataSource: NSObject, UITableViewDataSource {
    
    var selectedFilter : [SearchPopupFilter] = [SearchPopupFilter.topRated]
    var selectedFilterHighscore : [HighscorePopupFilter] = [HighscorePopupFilter.points]
    
    var destinationSearch : SearchViewController?
    var desitinationHighscore : HighscoreViewController?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let destination = destinationSearch {
            return SearchPopupFilter.allCases.count
        }
        return HighscorePopupFilter.allCases.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: SearchIdentifiers.filterPopupCell.identifier)!
        if let destination = destinationSearch {
            cell.textLabel?.text = SearchPopupFilter.allCases[indexPath.row].name
            
            let filter = SearchPopupFilter.allCases[indexPath.row]
            if selectedFilter.contains(filter){
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }
            
            cell = setupCellDesign(cell)
            
            return cell
        }
        if let destination = desitinationHighscore {
            cell.textLabel?.text = HighscorePopupFilter.allCases[indexPath.row].name
            
            let filter = HighscorePopupFilter.allCases[indexPath.row]
            if selectedFilterHighscore.contains(filter){
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }
            
            cell = setupCellDesign(cell)
            
            return cell
        }
        
        return cell
        
    }
    
    func toggleAccessory(_ cell : Int){
        let selectedFilterCell = SearchPopupFilter.allCases[cell]
        if !selectedFilter.contains(selectedFilterCell){
            //Only one Filter selected at once
            selectedFilter.removeAll()
            selectedFilter.append(selectedFilterCell)
        }
    }
    
    func toggleHighscoreAccessory(_ cell : Int) {
        let selectedFilterCell = HighscorePopupFilter.allCases[cell]
        if !selectedFilterHighscore.contains(selectedFilterCell){
            //Only one Filter selected at once
            selectedFilterHighscore.removeAll()
            selectedFilterHighscore.append(selectedFilterCell)
        }
    }
    
    private func setupCellDesign(_ cell : UITableViewCell) -> UITableViewCell{
        cell.selectionStyle = .none
        cell.tintColor = AppColor.tint
        cell.backgroundColor = AppColor.background
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    

}
