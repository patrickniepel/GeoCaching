//
//  Rank.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 08.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import Foundation

enum Rank {
    case schnitzler
    case otherRankName
    case guru
    
    static func getRank(forPoints points: Int) -> Rank {
        switch points {
        case 0...999_999: return Rank.schnitzler
        case 1_000_000...99_999_999: return Rank.otherRankName
        default: return Rank.guru
        }
    }
    
    var name: String {
        switch self {
        case .schnitzler: return "Schnitzler"
        case .otherRankName: return "Weitere Namen überlegen"
        case .guru: return "Guru"
        }
    }
}
