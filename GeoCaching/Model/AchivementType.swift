//
//  AchivementType.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 08.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import Foundation

enum AchivementType {
    case geoSchnitzler
    case noob
    
    static let allAchivementTypes = [AchivementType.geoSchnitzler, .noob]
    
    init?(filename: String) {
        switch filename {
        case "geoSchnitzler.3dModelFileNamePostfix": self = .geoSchnitzler
        case "noob.3dModelFileNamePostfix": self = .noob
        default: return nil
        }
    }
    
    var filename: String {
        switch self {
        case .geoSchnitzler: return "geoSchnitzler.3dModelFileNamePostfix"
        case .noob: return "noob.3dModelFileNamePostfix"
        }
    }
    var title: String {
        switch self {
        case .geoSchnitzler: return "Schnitzel di Schnitzel"
        case .noob: return "Kack Noob!"
        }
    }
    var conditionDescription: String {
        switch self {
        case .geoSchnitzler: return "To earn this achivement you have to lead a highscore."
        case .noob: return "To earn this achivement you have to be you."
        }
    }
}
