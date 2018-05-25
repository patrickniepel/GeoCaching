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
    case addQuestArea
    case addGameCategories
    
    var identifier: String {
        switch self {
        case .createQuest: return "createSegueCreateQuest"
        case .addQuestArea: return "createSegueAddQuestArea"
        case .addGameCategories: return "createSegueAddGameCategories"
        }
    }
}
