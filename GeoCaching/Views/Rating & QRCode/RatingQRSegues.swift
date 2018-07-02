//
//  RatingQRSegues.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 27.06.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

enum RatingQRSegues {
    case displayRating
    
    var identifier: String {
        switch self {
        case .displayRating: return "gameSegueDisplayRating"
        }
    }

}
