//
//  QuestCategory.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 06.06.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

enum QuestCategory {
    case nature
    case city
    case under10km
    
    static var allCases: [QuestCategory] = [.nature, .city, .under10km]
    
    init?(dbName: String) {
        switch dbName {
        case "nature": self = .nature
        case "city": self = .city
        case "under10km": self = .under10km
        default: return nil
        }
    }
    
    var name: String {
        switch self {
        case .nature: return "nature"
        case .city: return "city"
        case .under10km: return "under10km"
        }
    }
    
    var dbName: String {
        switch self {
        case .nature: return "nature"
        case .city: return "city"
        case .under10km: return "under10km"
        }
    }
}
