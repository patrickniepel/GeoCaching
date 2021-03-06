//
//  AchievementController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 17.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

struct AchievementController {
    
    func getSceneName(for achievement: Achivement) -> String {
        return achievement.type.filename
    }
    
    func getAchievementImageName(for achievement: Achivement) -> String {
        return "\(achievement.type)"
    }
}
