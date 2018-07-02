//
//  ProfileController.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 02.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import Foundation
import Firebase


struct ProfileController {
    
    private var userDB: DatabaseReference
    
    init() {
        userDB = Database.database().reference().child("users")
    }
    
    func downloadUserProfile(withUserID userID: String, completion: @escaping (User?, Error?) -> ()) {
        userDB.observeSingleEvent(of: .value) { (dataSnapshot) in
            for userSnapshot in dataSnapshot.children.allObjects as! [DataSnapshot] {
                if let user = User(snapshot: userSnapshot) {
                    if user.id == userID {
                        completion(user, nil)
                        return
                    }
                } else {
                    completion(nil, ProfileError.failedFetchingProfile)
                    return
                }
            }
            completion(nil, ProfileError.userNotFound)
        }
    }
    
    func downloadUserProfileImage(forUserID userID: String, completion: @escaping (UIImage?) -> ()) {
        let downloadedImage = UIImage(named: "profileImage")
        completion(downloadedImage)
    }
    
    func updateUserPoints(pointsToAdd: Int) {
        if let userID = Auth.auth().currentUser?.uid {
            userDB.child(userID).observeSingleEvent(of: .value) { (dataSnapshot) in
                if let user = User(snapshot: dataSnapshot) {
                    let oldUserPoints = user.points
                    let newUserPoints = oldUserPoints + pointsToAdd
                    
                    self.userDB.child(userID).child("points").setValue(newUserPoints)
                }
            }
        }
    }
    
    func downloadUserProfileAndObserve(completion: @escaping (User?, Error?) -> ()) {
        if let userID = Auth.auth().currentUser?.uid {
            userDB.child(userID).observe(.value) { (dataSnapshot) in
                print("11111")
                if let user = User(snapshot: dataSnapshot) {
                    completion(user, nil)
                } else {
                    completion(nil, ProfileError.failedFetchingProfile)
                }
            }
        } else {
            completion(nil, ProfileError.failedFetchingProfile)
        }
    }
    
    func updateUserProfile(newAchivementType: AchivementType) {
        if let userID = Auth.auth().currentUser?.uid {
            let achivement = Achivement(type: newAchivementType)
            userDB.child(userID).observeSingleEvent(of: .value) { (dataSnapshot) in
                if var user = User(snapshot: dataSnapshot) {
                    user.earnedAchivements.append(achivement)
                    self.userDB.child(userID).setValue(user.toDictionary)
                }
            }
        }
    }
    
    func updateUserProfile(picture: UIImage) {
        
    }
}
