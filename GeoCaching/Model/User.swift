//
//  User.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 08.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseDatabase

struct User {
    var id: String
    var username: String
    var usernameWithOnlineStatus: NSAttributedString {
        let attributedString = NSMutableAttributedString(string: username)
        if isOnline {
            let pointString = NSAttributedString(string: " • ", attributes: [NSAttributedStringKey.foregroundColor : UIColor.green])
            attributedString.append(pointString)
            // let onlineString = NSAttributedString(string: "online")//, attributes: [NSAttributedStringKey.font : UIFont(name: "Helvetica", size: 14.0)!])
            //attributedString.append(onlineString)
        }
        return attributedString
    }
    var userImage: UIImage?
    var userImageFileName: String {
        return id
    }
    var isPresenter: Bool
    var points: Int
    var formattedPoints: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = "."
        numberFormatter.numberStyle = .decimal
        let points = NSNumber(value: self.points)
        return "\(numberFormatter.string(from: points) ?? "0") points"
    }
    var earnedAchivements: [Achivement] = []
    var rank: Rank {
        return Rank.getRank(forPoints: points)
    }
    var currentLocation: CLLocationCoordinate2D? = nil
    private var isOnline: Bool {
        return true // TODO: ✅⚠️ zum debuggen auskommentiert currentLocation != nil
    }
    var currentGameId : String?
    var currentQuestId : String?
    
    init (id: String, username: String, userImage: UIImage?,
          isPresenter: Bool, points: Int, earnedAchivements: [Achivement]) {
        self.id = id
        self.username = username
        self.userImage = userImage
        self.isPresenter = isPresenter
        self.points = points
        self.earnedAchivements = earnedAchivements
        self.currentGameId = nil
        self.currentQuestId = nil
    }
    
    init (id: String, username: String, userImage: UIImage?,
          isPresenter: Bool, points: Int, earnedAchivements: [Achivement], currentGameId : String, currentQuestId : String) {
        self.id = id
        self.username = username
        self.userImage = userImage
        self.isPresenter = isPresenter
        self.points = points
        self.earnedAchivements = earnedAchivements
        self.currentGameId = currentGameId
        self.currentQuestId = currentQuestId
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String:Any],
            let username = dict["username"] as? String,
            let isPresenter = dict["isPresenter"] as? Bool,
            let points = dict["points"] as? Int
        
            else {return nil}
        
        if let achievementDictionaries = dict["earnedAchivements"] as? [[String:Any]] {
            var achievements: [Achivement] = []
            for achievementDict in achievementDictionaries {
                if let achievement =  Achivement(dict: achievementDict) {
                    print(achievement)
                    achievements.append(achievement)
                }
            }
            self.earnedAchivements = achievements
        }
        
        
        self.id = snapshot.key
        self.username = username
        self.isPresenter = isPresenter
        self.points = points
        self.currentGameId = dict["currentGameId"] as? String
        self.currentQuestId = dict["currentQuestId"] as? String
    }
    
    var toDictionary: [String:Any] {
        return [
            "username": username,
            "isPresenter": isPresenter,
            "points": points,
            "earnedAchivements": earnedAchivements.map { $0.toDictionary },
            "currentGameId" : currentGameId,
            "currentQuestId" : currentQuestId
        ]
    }
}
