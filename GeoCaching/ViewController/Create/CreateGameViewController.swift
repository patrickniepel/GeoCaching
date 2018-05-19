//
//  CreateGameViewController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 18.04.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class CreateGameViewController: UIViewController {
    @IBOutlet weak var gameNameTextField: UITextField!
    @IBOutlet weak var shortDescriptionTextField: UITextField!
    @IBOutlet weak var longDescriptionTextView: UITextView!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var questCollectionView: UICollectionView!
    @IBOutlet var textElementCollection: [UILabel]!
    @IBOutlet var buttonElementCollection: [UIButton]!
    
    private var gameUploadController: GameUploadController!
    private var gameCreatorController: CreateGameController!

    
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
        
        buttonElementCollection.forEach { $0.setTitleColor(AppColor.tint, for: .normal) }
        textElementCollection.forEach { $0.textColor = AppColor.text }
        longDescriptionTextView.textColor = AppColor.text
    }
    
    func setupData() {
        gameUploadController = GameUploadController()
        gameCreatorController = CreateGameController(questionType: .image)
        gameCreatorController.delegate = self
        
        gameNameTextField.addTarget(self, action: #selector(gameNameDidChange), for: .editingChanged)
        shortDescriptionTextField.addTarget(self, action: #selector(shortDescriptionDidChange), for: .editingChanged)
        longDescriptionTextView.delegate = self
    }
    
    @IBAction func addCategoryAction(_ sender: UIButton) {
    }
    @IBAction func addQuestAction(_ sender: UIButton) {
    }
    
    @objc func gameNameDidChange() {
        print("-gameNameDidChange")
        if let gameName = gameNameTextField.text {
            gameCreatorController.set(name: gameName)
        }
    }
    
    @objc func shortDescriptionDidChange() {
        print("-shortDescriptionDidChange")
        if let shortDescription = shortDescriptionTextField.text {
            gameCreatorController.set(shortDescription: shortDescription)
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


// MARK: - Create Quest Controller Delegate

extension CreateGameViewController: CreateGameControllerDelegate {
    func gameInfoDidChange(duration: Double, length: Double) {
        durationLabel.text = "\(duration)"
        lengthLabel.text = "\(length)"
        print("info did change: \(duration) -- \(length)")
    }
    
    
    func canCreateGame(canCreate: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = canCreate
    }
    
    func createGame(progress: Float) {
        print("PROGRESS: \(progress)")
        self.title = String(format: "%.0f %%", progress*100)
    }
}

extension CreateGameViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print("-longDescriptionDidChange")
        if let longDescription = textView.text {
            gameCreatorController.set(longDescription: longDescription)
        }
    }
}




