//
//  CreateGameViewController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 18.04.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    
    private var gameUploadController: GameUploadController!

    
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
        view.backgroundColor = AppColor.background
    }
    
    func setupData() {
        gameUploadController = GameUploadController()
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




