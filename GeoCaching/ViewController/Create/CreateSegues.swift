//
//  CreateSegues.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 16.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import Foundation

enum CreateStoryboardSegue {
    case createQuest
    
    var identifier: String {
        switch self {
        case .createQuest: return "createSegueCreateQuest"
        }
    }
}
