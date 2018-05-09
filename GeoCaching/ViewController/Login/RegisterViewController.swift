//
//  RegisterViewController.swift
//  GeoCaching
//
//  Created by Carl Philipp Knoblauch on 09.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var usernameBackgroundView: UIView!
    @IBOutlet weak var emailBackgroundView: UIView!
    @IBOutlet weak var passwordBackgroundView: UIView!
    
    @IBOutlet weak var usernameSeparatorView: UIView!
    @IBOutlet weak var emailSeparatorView: UIView!
    @IBOutlet weak var passwordSeparatorView: UIView!
    
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet weak var registerButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDesign()
        setupText()
        setupData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupDesign(){
        
        usernameBackgroundView.layer.cornerRadius = 10
        emailBackgroundView.layer.cornerRadius = 10
        passwordBackgroundView.layer.cornerRadius = 10
        
        usernameBackgroundView.layer.borderWidth = 1
        emailBackgroundView.layer.borderWidth = 1
        passwordBackgroundView.layer.borderWidth = 1
        
        usernameBackgroundView.layer.borderColor = AppColor.tint.cgColor
        usernameBackgroundView.backgroundColor = .clear
        emailBackgroundView.layer.borderColor = AppColor.tint.cgColor
        emailBackgroundView.backgroundColor = .clear
        passwordBackgroundView.layer.borderColor = AppColor.tint.cgColor
        passwordBackgroundView.backgroundColor = .clear
        
        usernameSeparatorView.backgroundColor = AppColor.tint
        emailSeparatorView.backgroundColor = AppColor.tint
        passwordSeparatorView.backgroundColor = AppColor.tint
    
        
        // Creating the same constraint using constraintLessThanOrEqualToConstant: TEST
        // usernameBackgroundView.widthAnchor.constraint(lessThanOrEqualToConstant: 10.0).isActive = true
        
    }

    func setupText() {
        
    }
    
    func setupData() {
        
    }


    
}


// MARK: - Actions

extension RegisterViewController {
    @IBAction func registerAction(_ sender: UIButton) {
    }
    
    @IBAction func skipAction(_ sender: UIButton) {
        showGameViewController()
    }
}


// MARK: - Navigation

extension RegisterViewController {
    func showGameViewController() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let tabBarCtrl = appDelegate.createAppTabBarController()
        let navigationCtrl = UINavigationController(rootViewController: tabBarCtrl)
        navigationCtrl.navigationBar.barTintColor = AppColor.navigationBar
        navigationCtrl.navigationBar.tintColor = AppColor.text
        present(navigationCtrl, animated: true)
    }
}
