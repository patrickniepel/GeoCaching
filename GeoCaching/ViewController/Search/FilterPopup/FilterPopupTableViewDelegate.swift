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
    
    var destinationSearch : SearchViewController?
    var desitinationHighscore : HighscoreViewController?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dataSource = tableView.dataSource as! FilterPopupTableViewDataSource
        tableView.deselectRow(at: indexPath, animated: true)
        dataSource.toggleAccessory(indexPath.row)
        tableView.reloadData()
        //destination.games.sorted(by: { $0.id > $1.id })
        let filter : SearchPopupFilter = SearchPopupFilter.allCases[indexPath.row]
        if let destination = destinationSearch{
            switch filter{
            case .topRated:
                destination.games.sort(by: { $0.rating > $1.rating })
            case .distance:
                destination.games.sort(by: { $0.length > $1.length })
            case .duration:
                print(destination.games[2].duration)
                destination.games.sort(by: { $0.duration > $1.duration })
                print(destination.games[2].duration)
            case .stations:
                destination.games.sort(by: { $0.quests.count > $1.quests.count })
            case .local:
                break
            case .friends:
                break
            }
            destination.cardCollectionView.reloadData()
        }
    }
}
