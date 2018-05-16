//
//  CreateQuestViewController.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 16.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit
import MobileCoreServices

class CreateQuestViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var answerTableView: UITableView!
    @IBOutlet weak var questImageView: UIImageView!
    
    private var answers: [String] = []
    
    private var answerTableViewDelegate: CreateQuestAnswerTableViewDelegate!
    private var answerTableViewDataSource: CreateQuestAnswerTableViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDesign()
        setupText()
        setupData()
        setupGestures()
    }

    
    func setupText() {
    }
    
    func setupDesign() {
        view.backgroundColor = AppColor.background
        questionLabel.textColor = AppColor.text
        answersLabel.textColor = AppColor.text
        answerTableView.backgroundColor = AppColor.background
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self, action: #selector(addQuestAction))
    }
    
    func setupData() {
        answerTableViewDataSource = CreateQuestAnswerTableViewDataSource()
        answerTableView.dataSource = answerTableViewDataSource
        
        answerTableViewDelegate = CreateQuestAnswerTableViewDelegate()
        answerTableView.delegate = answerTableViewDelegate
    }
    
    func setupGestures() {
        let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageWasTapped))
        questImageView.isUserInteractionEnabled = true
        questImageView.addGestureRecognizer(imageTapGestureRecognizer)
    }
    
    func addQuestAction() {
        print("Add quest action")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


// MARK: - Image Picker

extension CreateQuestViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc private func imageWasTapped() {
        let sourceType = UIImagePickerControllerSourceType.photoLibrary
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let availableMediaTypes = UIImagePickerController.availableMediaTypes(for: sourceType) ?? []
            let imagePickerCtrl = UIImagePickerController()
            imagePickerCtrl.mediaTypes = availableMediaTypes
            imagePickerCtrl.allowsEditing = false
            imagePickerCtrl.sourceType = sourceType
            imagePickerCtrl.delegate = self
            present(imagePickerCtrl, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            questImageView.image = image
        }
        
        dismiss(animated: true)
    }
}
