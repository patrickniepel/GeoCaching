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
    
    @IBOutlet weak var indicatorView: NVActivityIndicatorView!
    
    
    
    var authController = AuthController()
    
    var emailText = ""
    var passwordText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDesign()
        setupText()
        setupData()
        
        hideKeyboardWhenTappedAround()
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
        
        usernameTextField.tintColor = AppColor.tint
        emailTextField.tintColor = AppColor.tint
        passwordTextField.tintColor = AppColor.tint
        
        indicatorView.type = .pacman
        indicatorView.color = AppColor.tint
        indicatorView.layer.cornerRadius = 10
        
    }
    
    func setupText() {
        title = "Register"
        
    }
    
    func setupData() {
        
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.text = emailText
        passwordTextField.text = passwordText
        
    }
    
    func registerUser() {
        
        indicatorView.startAnimating()
        
        print("Register User")
        registerButtonOutlet.isEnabled = false
        
        authController.register(withEmail: emailTextField.text! , andPassword: passwordTextField.text!, username: usernameTextField.text!) {
            (user, error) in
            
            if let error = error{
                self.handleErrorPopupDialog(error: error)
                self.registerButtonOutlet.isEnabled = true
            }else if let user = user{
                print("Hello \(user)")
                self.showGameViewController()
            }
            
            self.indicatorView.stopAnimating()
        }
    }
}


// MARK: - Actions

extension RegisterViewController {
    @IBAction func registerAction(_ sender: UIButton) {
        registerUser()
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


// MARK: - Keyboard

extension RegisterViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField.tag {
        case 1:
            emailTextField.becomeFirstResponder()
        case 2:
            passwordTextField.becomeFirstResponder()
        case 3:
            registerUser()
        default:
            self.view.endEditing(true)
        }
        
        return false
    }
}

