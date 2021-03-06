//
//  SearchIdentifiers.swift
//  GeoCaching
//
//  Created by Philipp on 16.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

enum SearchIdentifiers {
    case filterPopupCell
    case segue2FilterPopup
    case segue2GameDetail
    case segue2Game
    case gameDetailHighscoreHeaderCell
    case gameDetailHighscoreTableViewCell
    case gameDownloadNotification

    
    var identifier : String{
        switch self {
        case .filterPopupCell:                      return "SearchFilterCell"
        case .segue2FilterPopup:                    return "Segue2FilterPopup"
        case .segue2GameDetail:                     return "Segue2GameDetail"
        case .segue2Game:                           return "Segue2Game"
        case .gameDetailHighscoreHeaderCell:        return "GameDetailHighscoreHeaderCell"
        case .gameDetailHighscoreTableViewCell:     return "GameDetailHighscoreTableViewCell"
        case .gameDownloadNotification:             return "GameDownloadNotification"
        }
    }
}
