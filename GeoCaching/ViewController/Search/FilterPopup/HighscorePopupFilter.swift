//
//  HighscorePopupFilter.swift
//  GeoCaching
//
//  Created by Philipp on 02.07.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import Foundation

enum HighscorePopupFilter : Int {
    case points
    case distance
    case duration
    case games
    case achievements
    case local
    case friends
    
    static var allCases = [HighscorePopupFilter.points, .distance, .duration, .games, .achievements, .local, .friends]
    
    var name : String {
        switch self {
        case .points:               return "Points"
        case .distance:             return "Distance"
        case .duration:             return "Duration"
        case .games:                return "Games played"
        case .achievements:         return "Achievements"
        case .local:                return "Local"
        case .friends:              return "Routes of Friends"
        }
    }
    
    func getCaseByNumber(numberForCase number : Int) -> String{
        return HighscorePopupFilter(rawValue: number)?.name ?? "Points"
    }
}
