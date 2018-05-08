//
//  CreateGameViewController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 18.04.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    
    var testButton = UIButton(frame: CGRect(x: 30, y: 100, width: 200, height: 40))
    var auth = AuthController()

    override func viewDidLoad() {
        super.viewDidLoad()
        testButton.backgroundColor = UIColor.orange
        testButton.setTitle("Test me :)", for: .normal)
        testButton.addTarget(self, action: #selector(testFirebaseMethods), for: .touchUpInside)
        view.addSubview(testButton)
        
    }

    @objc func testFirebaseMethods() {
        let email = "hello@web.de"
        let password = "passwort123"
//        auth.register(withEmail: email, andPassword: password, username: "Usernameee") { (user, error) in
//            if let error = error {
//                self.handleErrorAlert(error: error)
//            } else if let user = user {
//                print("User: \(user)")
//            }
//        }
        auth.login(withEmail: email, andPassword: password) { (user, error) in
            if let error = error {
                self.handleErrorAlert(error: error)
            } else if let user = user {
                print("User: \(user)")
            }
        }
    }
    
    func handleErrorAlert(error: Error) {
        var errorMessage = ""
        
        if let authError = error as? AuthError {
            errorMessage = authError.localizedDescription
        } else if let profileError = error as? ProfileError {
            errorMessage = profileError.localizedDescription
        } else {
            errorMessage = error.localizedDescription
        }
        
        let errorAlert = UIAlertController(title: "Error occured", message: "\(errorMessage)", preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(errorAlert, animated: true)
    }
}





