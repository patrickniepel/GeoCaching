//
//  SearchPopupFilter.swift
//  GeoCaching
//
//  Created by Philipp on 16.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

enum SearchPopupFilter : Int {
    case topRated
    case distance
    case duration
    case stations
    case local
    case friends
    
    static var allCases = [SearchPopupFilter.topRated, .distance, .duration, .stations, .local, .friends]
    
    var name : String {
        switch self {
            case .topRated:             return "Top Rated"
            case .distance:             return "Distance"
            case .duration:             return "Duration"
            case .stations:             return "Number of stations"
            case .local:                return "Local"
            case .friends:              return "Routes of Friends"
        }
    }
    
    func getCaseByNumber(numberForCase number : Int) -> String{
        return SearchPopupFilter(rawValue: number)?.name ?? "Top Rated"
    }
}
