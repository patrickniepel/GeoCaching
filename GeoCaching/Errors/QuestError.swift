//
//  QuestError.swift
//  GeoCaching
//
//  Created by Philipp on 13.06.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

enum QuestError: Error {
    case failedFetchingQuest
    case questNotFound
    
    var localizedDescription : String{
        switch self {
        case .failedFetchingQuest: return "A quest error occured."
        case .questNotFound: return "Quest not found."
        }
    }
}
