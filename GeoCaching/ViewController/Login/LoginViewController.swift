//
//  LoginViewController.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 08.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit
import Foundation
//import NVActivityIndicatorView

class LoginViewController: UIViewController , NVActivityIndicatorViewable{
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordBackgroundView: UIView!
    @IBOutlet weak var emailBackgroundView: UIView!
    
    @IBOutlet weak var passwordSeparatorView: UIView!
    @IBOutlet weak var emailSeparatorView: UIView!
    
    @IBOutlet weak var loginButtonOutlet: UIGeoButton!
    @IBOutlet weak var registerButtonOutlet: UIButton!
    
    @IBOutlet weak var animationView: SchnitzlrBoarWaitingAnimationView!
    
    
    @IBOutlet weak var indicatorView: NVActivityIndicatorView!
    
    let authController = AuthController()
    
    var timer : Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDesign()
        setupText()
        setupData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkUserSignedIn()
        startAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopAnimation()
    }
    
    // MARK: - Setup
    
    func setupText() {
        title = "Welcome"
    }
    
    func setupDesign() {
        makeButtonViewsPretty(views: [emailBackgroundView, passwordBackgroundView])

        registerButtonOutlet.layer.cornerRadius = 10
        registerButtonOutlet.layer.borderWidth = 1
        registerButtonOutlet.layer.borderColor = AppColor.tint.cgColor
        registerButtonOutlet.backgroundColor = .clear
        
        passwordTextField.tintColor = AppColor.tint
        emailTextField.tintColor = AppColor.tint
        
        emailSeparatorView.backgroundColor = AppColor.tint
        passwordSeparatorView.backgroundColor = AppColor.tint
        
        indicatorView.type = .pacman
        indicatorView.color = AppColor.tint
        indicatorView.layer.cornerRadius = 10
        //      indicatorView.backgroundColor = AppColor.background
        
    }
    
    func makeButtonViewsPretty(views: [UIView]){
        _ = views.map { $0.makeButtonViewPretty() }
    }
    
    
    func setupData() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        timer = Timer()
        
        hideKeyboardWhenTappedAround()
    }
    
    func startAnimation() {
        
        self.animationView.addSchnitzlrBoarWaitingAnimation()
        
        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true, block: { (timer) in
            self.animationView.addSchnitzlrBoarWaitingAnimation()
        })
    }
    
    func stopAnimation() {
        timer.invalidate()
    }
    
    func checkUserSignedIn() {

        if authController.checkIfUserAlreadySignedI() {
            dismissLogin()
            print("""
            ##########
            Auto Login User
            ##########
            """)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == LoginStoryboardSegue.register.identifier {
            guard let destVC = segue.destination as? RegisterViewController else {
                return
            }
            
            destVC.emailText = emailTextField.text!
            destVC.passwordText = passwordTextField.text!
        }
    }
    
    func loginUser(){
        
        indicatorView.startAnimating()
        
        loginButtonOutlet.isEnabled = false
        
        
        authController.login(withEmail: emailTextField.text!, andPassword: passwordTextField.text!) {
            (user, error) in
            
            if let error = error{
                //self.handleErrorAlert(error: error)
                self.handleErrorPopupDialog(error: error)
                self.loginButtonOutlet.isEnabled = true
            }else if let user = user{
                print(user)
                self.dismissLogin()
            }
            
            self.indicatorView.stopAnimating()
        }
    }
    
}


// MARK: - IBActions

extension LoginViewController {
    @IBAction func loginAction(_ sender: UIButton) {
        print("login")
        
        loginUser()
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        
    }
    
    @IBAction func SkipAction(_ sender: UIButton) {
        dismissLogin()
    }
    
}


// MARK: - Navigation

extension LoginViewController {
    func dismissLogin() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let tabBarCtrl = appDelegate.createAppTabBarController()
//        present(tabBarCtrl, animated: true)
        
        self.dismiss(animated: true, completion: nil)
    }
}


// MARK: - Keyboard

extension LoginViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField.tag {
        case 1:
            passwordTextField.becomeFirstResponder()
        case 2:
            loginUser()
        default:
            self.view.endEditing(true)
        }
        
        return false
    }
}
