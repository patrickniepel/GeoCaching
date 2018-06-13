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
        print("\(achievement.type)")
        return "\(achievement.type).dae"
        //return "TrophyBronze.dae"
    }
    
    func getAchievementImageName(for achievement: Achivement) -> String {
        return "\(achievement.type)"
        //return "achievementTest"
    }
}
