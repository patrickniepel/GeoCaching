//
//  Extension+UIViewController.swift
//  GeoCaching
//
//  Created by Carl Philipp Knoblauch on 17.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func handleErrorPopupDialog(error: Error) {
        var errorMessage = ""
        
        if let authError = error as? AuthError {
            errorMessage = authError.localizedDescription
        } else if let profileError = error as? ProfileError {
            errorMessage = profileError.localizedDescription
        } else {
            errorMessage = error.localizedDescription
        }
        
        let popup = PopupDialog(title: "Error", message: errorMessage)
        popup.addButton(PopupDialogButton(title: "OK", height: 60, dismissOnTap: true, action: {
            print("Hello inside Button Action from Popup Error")
        }))
        
        showPopupDialog(dialog: popup)
    }
    
    func informationPopupDialog(title: String, message: String, actionText: String, delegate: ActiveGameDelegate? = nil, vc: QuestionViewController? = nil) {
        let popup = PopupDialog(title: title, message: message)
        popup.addButton(PopupDialogButton(title: "Continue", height: 60, dismissOnTap: true, action: {
            if let delegate = delegate, let vc = vc {
                delegate.userAnsweredQuestion(vc: vc)
            }
        }))
        showPopupDialog(dialog: popup)
    }
    
    func logoutDialog(title: String, message: String, authCtrl: AuthController) {
        let popup = PopupDialog(title: title, message: message)
        popup.addButton(PopupDialogButton(title: "Cancel", height: 60, dismissOnTap: true, action: {

        }))
        popup.addButton(PopupDialogButton(title: "Logout", height: 60, dismissOnTap: true, action: {
            authCtrl.logoutUser()
            print("Logout User")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let loginViewCtrl = appDelegate.goToLogin()
            self.present(loginViewCtrl, animated: false, completion: nil)
        }))
        showPopupDialog(dialog: popup)
    }
    
    private func showPopupDialog(dialog: PopupDialog) {
        let dialogAppearance = PopupDialogDefaultView.appearance()
        
        dialogAppearance.backgroundColor      = AppColor.background
        dialogAppearance.titleFont            = .boldSystemFont(ofSize: 18)
        dialogAppearance.titleColor           = .white
        dialogAppearance.titleTextAlignment   = .center
        dialogAppearance.messageFont          = .systemFont(ofSize: 16)
        dialogAppearance.messageColor         = UIColor(white: 0.6, alpha: 1)
        dialogAppearance.messageTextAlignment = .center
        
        let buttonAppearance = PopupDialogButton.appearance()
        
        // PopupDialogButton button
        buttonAppearance.titleFont      = .systemFont(ofSize: 16)
        buttonAppearance.titleColor     = .white
        buttonAppearance.buttonColor    =  AppColor.background
        buttonAppearance.separatorColor = .black
        
        
        present(dialog, animated: true)
    }
    
    func alert(for title: String, message: String, actionText: String, delegate: ActiveGameDelegate? = nil, vc: QuestionViewController? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionText, style: .default) { action -> Void in
            if let delegate = delegate, let vc = vc {
                delegate.userAnsweredQuestion(vc: vc)
            }
        }
        
        alert.addAction(action)
        return alert
    }

}
