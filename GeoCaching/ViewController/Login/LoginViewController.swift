//
//  LoginViewController.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 08.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDesign()
        setupText()
        setupData()
    }
    
    
    // MARK: - Setup
    
    func setupText() {
        
    }
    
    func setupDesign() {
        emailLabel.textColor = AppColor.text
        passwordLabel.textColor = AppColor.text
        usernameLabel.textColor = AppColor.text
        
        self.view.backgroundColor = AppColor.background
    }
    
    func setupData() {
        
    }
}


// MARK: - IBActions

extension LoginViewController {
    @IBAction func loginAction(_ sender: UIButton) {
        print("login")
        showGameViewController()
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        print("register")
    }
}


// MARK: - Navigation

extension LoginViewController {
    func showGameViewController() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let tabBarCtrl = appDelegate.createAppTabBarController()
        let navigationCtrl = UINavigationController(rootViewController: tabBarCtrl)
        navigationCtrl.navigationBar.barTintColor = AppColor.navigationBar
        navigationCtrl.navigationBar.tintColor = AppColor.text
        present(navigationCtrl, animated: true)
    }
}
