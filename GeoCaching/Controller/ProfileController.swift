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
}
