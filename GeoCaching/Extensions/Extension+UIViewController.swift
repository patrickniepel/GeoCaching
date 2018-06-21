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
        
        
        present(popup, animated: true)
    }
    
    func alert(for title: String, message: String, actionText: String, useDelegate: Bool) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionText, style: .default) { action -> Void in
            
        }
        
        alert.addAction(action)
        return alert
    }

}
