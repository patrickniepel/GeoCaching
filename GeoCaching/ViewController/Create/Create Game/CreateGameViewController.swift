//
//  CreateGameViewController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 18.04.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreLocation


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
    
    private var questCollectionViewDelegate: CreateGameQuestOverviewCollectionViewDelegate!
    private var questCollectionViewDataSource: CreateGameQuestOverviewCollectionViewDataSource!
    private var questCollectionViewDragDelegate: CreateGameQuestOverviewCollectionViewDragDelegate!
    private var questCollectionViewDropDelegate: CreateGameQuestOverviewCollectionViewDropDelegate!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDesign()
        setupText()
        setupData()
        setupGestures()
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
        
        questCollectionViewDataSource = CreateGameQuestOverviewCollectionViewDataSource()
        questCollectionView.dataSource = questCollectionViewDataSource
        
        questCollectionViewDelegate = CreateGameQuestOverviewCollectionViewDelegate(vCtrl: self)
        questCollectionView.delegate = questCollectionViewDelegate
        
        questCollectionViewDragDelegate = CreateGameQuestOverviewCollectionViewDragDelegate()
        questCollectionViewDropDelegate = CreateGameQuestOverviewCollectionViewDropDelegate()
        questCollectionView.dragInteractionEnabled = true
        questCollectionView.dragDelegate = questCollectionViewDragDelegate
        questCollectionView.dropDelegate = questCollectionViewDropDelegate
        
        questCollectionViewDropDelegate.delegate = self
    }
    
    func setupGestures() {
        let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageWasTapped))
        gameImageView.isUserInteractionEnabled = true
        gameImageView.addGestureRecognizer(imageTapGestureRecognizer)
    }
    
    @IBAction func addCategoryAction(_ sender: UIButton) {
    }
    
    @IBAction func addQuestAction(_ sender: UIButton) {
        let identifier = CreateStoryboardSegue.createQuest.identifier
        performSegue(withIdentifier: identifier, sender: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == CreateStoryboardSegue.addGameCategories.identifier {
            // Create new Quest
            print("### addGameCategories")
            let destCtrl = segue.destination as! AddGameCategoriesTableViewController
            destCtrl.delegate = self
            destCtrl.selectedCategories = Set(gameCreatorController.game.categories)
        } else if segue.identifier == CreateStoryboardSegue.editQuest.identifier {
            // Edit Quest
            print("### edit")
            if let questToEdit = sender as? Quest {
                let destCtrl = segue.destination as! CreateQuestViewController
                destCtrl.receivedQuestToEdit = questToEdit
                destCtrl.delegate = self
            }
        } else if segue.identifier == CreateStoryboardSegue.createQuest.identifier {
            print("### createQuest")
            let destCtrl = segue.destination as! CreateQuestViewController
            destCtrl.delegate = self
        }
    }
    
    private func displayCategories() {
        var result = ""
        for category in gameCreatorController.game.categories {
            if category.name == gameCreatorController.game.categories.last?.name {
                result += "\(category.name)"
            } else {
                result += "\(category.name), "
            }
        }
        categoriesLabel.text = result
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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


// MARK: - UITextViewDelegate

extension CreateGameViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print("-longDescriptionDidChange")
        if let longDescription = textView.text {
            gameCreatorController.set(longDescription: longDescription)
        }
    }
}


// MARK: - Add Game Categories Delegate

extension CreateGameViewController: AddGameCategoriesDelegate {
    func receive(selectedCategories: [QuestCategory]) {
        gameCreatorController.set(categories: selectedCategories)
        navigationController?.popViewController(animated: true)
        
        displayCategories()
    }
}


// MARK: - CreateGameQuestOverviewCollectionViewDelegate

extension CreateGameViewController: CreateGameQuestOverviewCollectionViewDataChangedDelegate {
    
    func didMovedQuest(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath) {
        print("TODO ✅ @Patrick - Calculate new route - source: \(sourceIndexPath) - dest: \(destinationIndexPath)")
    }
    
}


// MARK: - CreateQuestDelegate

extension CreateGameViewController: CreateQuestDelegate {
    func didCreate(newQuest: Quest) {
        gameCreatorController.append(newQuest: newQuest)
        questCollectionViewDataSource.quests = gameCreatorController.game.quests
        
        let numberOfElements = questCollectionViewDataSource.quests.count
        let lastIndexPath = IndexPath(row: numberOfElements - 1, section: 0)
        questCollectionView.insertItems(at: [lastIndexPath])
        navigationController?.popViewController(animated: true)
    }
    
    func didUpdated(quest: Quest) {
        for index in 0..<gameCreatorController.game.quests.count {
            if quest.id == gameCreatorController.game.quests[index].id {
                gameCreatorController.update(quest: quest, atIndex: index)
                questCollectionViewDataSource.quests = gameCreatorController.game.quests
                
                let indexPathToUpdate = IndexPath(row: index, section: 0)
                questCollectionView.reloadItems(at: [indexPathToUpdate])
                break
            }
        }
        navigationController?.popViewController(animated: true)
    }
}


// MARK: - Image Picker

extension CreateGameViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
            gameImageView.image = image
            gameCreatorController.set(image: image)
        }
        
        dismiss(animated: true)
    }
}

