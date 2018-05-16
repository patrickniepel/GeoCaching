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

    
    var identifier : String{
        switch self {
        case .filterPopupCell:          return "SearchFilterCell"
        case .segue2FilterPopup:        return "Segue2FilterPopup"
        }
    }
}
