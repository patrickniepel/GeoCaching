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
        
        if let destination = destinationSearch{
            dataSource.toggleAccessory(indexPath.row)
            tableView.reloadData()
            let filter : SearchPopupFilter = SearchPopupFilter.allCases[indexPath.row]
            switch filter{
            case .topRated:
                destination.cardCollectionViewDataSource.games.sort(by: { $0.rating > $1.rating })
            case .distance:
                destination.cardCollectionViewDataSource.games.sort(by: { $0.length < $1.length })
            case .duration:
                destination.cardCollectionViewDataSource.games.sort(by: { $0.duration < $1.duration })
            case .stations:
                destination.cardCollectionViewDataSource.games.sort(by: { $0.quests.count < $1.quests.count })
            case .local:
                break
            case .friends:
                break
            }
            destination.cardCollectionView.reloadData()
        }
        
        if let destination = desitinationHighscore{
            dataSource.toggleHighscoreAccessory(indexPath.row)
            tableView.reloadData()
            let filter : HighscorePopupFilter = HighscorePopupFilter.allCases[indexPath.row]
            switch filter{
            case .points:
                destination.highscoreTableViewDataSource.data.sort(by: {
                    return $0.formattedPoints < $1.formattedPoints
                })
            case .distance:
                break
            case .duration:
                break
            case .games:
                break
            case .achievements:
                destination.highscoreTableViewDataSource.data.sort(by: {$0.earnedAchivements.count < $1.earnedAchivements.count})
            case .local:
                break
            case .friends:
                break
            }
            destination.highscoreTableView.reloadData()
        }
    }
}
