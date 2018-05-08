//
//  AuthController.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 02.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth


struct AuthController {
//    weak var delegate: AuthDelegate?
    
    private var profileCtrl = ProfileController()
    
    private var userDB: DatabaseReference
    
    init() {
        userDB = Database.database().reference().child("users")
    }
    
    func register(withEmail email: String, andPassword password: String, username: String, completion: @escaping (User?, Error?) -> ()) {
        checkIfUsernameIsAlreadyInUse(username: username) { (isAlreadyInUse, error) in
            
            if let error = error {
                completion(nil, error)
            } else if !isAlreadyInUse {
                
                Auth.auth().createUser(withEmail: email, password: password, completion: { (createdUser, error) in
                    if let error = error {
                        completion(nil, error)
                    } else if let createdUser = createdUser {
                        let user = User(id: createdUser.uid, username: username, userImage: nil,
                                        isPresenter: false, points: 0, earnedAchivements: [])
                        self.userDB.child(createdUser.uid).setValue(user.toDictionary)
                        completion(user, nil)
                    } else {
                        completion(nil, AuthError.error)
                    }
                })
                
            } else {
                completion(nil, AuthError.usernameInUse)
            }
            
        }
    }
    
    func login(withEmail email: String, andPassword password: String, completion: @escaping (User?, Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (logedInUser, error) in
            if let error = error {
                completion(nil, error)
            } else if let logedInUser = logedInUser {
                self.profileCtrl.downloadUserProfile(withUserID: logedInUser.uid, completion: { (user, error) in
                    if let error = error {
                        completion(nil, error)
                    } else if let user = user {
                        completion(user, nil)
                    }
                })
            } else {
                completion(nil, AuthError.error)
            }
        }
    }
    
    private func checkIfUsernameIsAlreadyInUse(username: String, completion: @escaping (Bool, Error?) -> Void) {
        userDB.observeSingleEvent(of: .value) { (dataSnapshot) in
            var usernameIsAlreadyInUse = false
            
            for userSnapshot in dataSnapshot.children.allObjects as! [DataSnapshot] {
                
                if let user = User(snapshot: userSnapshot) {
                    if user.username == username {
                        usernameIsAlreadyInUse = true
                        completion(usernameIsAlreadyInUse, nil)
                        return
                    }
                } else {
                    completion(usernameIsAlreadyInUse, AuthError.unknown)
                    return
                }
            }
            
            completion(usernameIsAlreadyInUse, nil)
        }
    }
}
