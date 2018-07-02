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


// Nach redesign geht Kategorien nicht mehr und publish Button muss noch mit der funktionalität belegt werden.
// Cells sind noch nicht wirklich schön 

class CreateGameViewController: UIViewController {
    @IBOutlet weak var gameNameTextField: UITextField!
    @IBOutlet weak var shortDescriptionTextField: UITextField!
    @IBOutlet weak var longDescriptionTextView: UITextView!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var questCollectionView: UICollectionView!
    @IBOutlet weak var publishButtonOutlet: UIButton!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var informationBackgroundView: UIView!
    
    @IBOutlet var textElementCollection: [UILabel]!
    @IBOutlet var buttonElementCollection: [UIButton]!
    
    private var gameUploadController: GameUploadController!
    private var gameCreatorController: CreateGameController!
    
    private var questCollectionViewDelegate: CreateGameQuestOverviewCollectionViewDelegate!
    private var questCollectionViewDataSource: CreateGameQuestOverviewCollectionViewDataSource!
    private var questCollectionViewDragDelegate: CreateGameQuestOverviewCollectionViewDragDelegate!
    private var questCollectionViewDropDelegate: CreateGameQuestOverviewCollectionViewDropDelegate!
    
    let routeCtrl = RouteController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Upload", style: .done, target: self, action: #selector(doIt))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Download", style: .done, target: self, action: #selector(doIt2))
        
        setupDesign()
        setupText()
        setupData()
        setupGestures()
    }
    
    @objc func doIt() {
//        print("START - UPLOAD")
//        let game = DummyContent.sharedInstance.universityGame
//        gameUploadController.upload(game: game) { (progress, error) in
//            print("Progress: \(progress) --- \(error)")
//        }
    }
    
    let gameDownloadController = GameDownloadController()
    @objc func doIt2() {
        print("START - DOWNLOAD")
        gameDownloadController.downloadAllGames { (allGames, error) in
            print("Download-Error: \(error)")
            for game in allGames {
                print("gameID: \(game.id) - image: \( game.image)")
                
                for quest in game.quests {
                    print("Quest: \(quest.id) - \(quest.image)")
                }
            }
        }
    }
    
    
    // MARK: - Setup
    
    func setupText() {
        
    }
    
    func setupDesign() {
        backgroundView.backgroundColor = AppColor.background
        longDescriptionTextView.textColor = AppColor.text
        scrollview.backgroundColor = AppColor.tint
        
        textElementCollection.forEach { $0.textColor = AppColor.text }
        buttonElementCollection.forEach {
            $0.setTitleColor(AppColor.tint, for: .normal)
            $0.layer.cornerRadius = 10
            $0.layer.borderColor = AppColor.tint.cgColor
            $0.layer.borderWidth = 1
        }
        
        gameNameTextField.backgroundColor = .clear
        gameNameTextField.layer.borderColor = AppColor.tint.cgColor
        gameNameTextField.layer.borderWidth = 1
        gameNameTextField.layer.cornerRadius = 10
        gameNameTextField.tintColor = AppColor.tint
        gameNameTextField.textColor = AppColor.text
        
        shortDescriptionTextField.backgroundColor = .clear
        shortDescriptionTextField.layer.borderColor = AppColor.tint.cgColor
        shortDescriptionTextField.layer.borderWidth = 1
        shortDescriptionTextField.layer.cornerRadius = 10
        shortDescriptionTextField.tintColor = AppColor.tint
        shortDescriptionTextField.textColor = AppColor.text
        
        longDescriptionTextView.backgroundColor = .clear
        longDescriptionTextView.layer.borderColor = AppColor.tint.cgColor
        longDescriptionTextView.layer.borderWidth = 1
        longDescriptionTextView.layer.cornerRadius = 10
        longDescriptionTextView.tintColor = AppColor.tint
        longDescriptionTextView.textColor = AppColor.text
        
        
        // Fat Publish Button
        publishButtonOutlet.layer.borderWidth = 2

        questCollectionView.layer.cornerRadius = 10
        questCollectionView.backgroundColor = AppColor.backgroundLighter
        
        informationBackgroundView.layer.cornerRadius = 10
        informationBackgroundView.backgroundColor = AppColor.backgroundLighter
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
        
        hideKeyboardWhenTappedAround()
    }
    
    func setupGestures() {
        let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageWasTapped))
        gameImageView.isUserInteractionEnabled = true
        gameImageView.addGestureRecognizer(imageTapGestureRecognizer)
    }
    
    @objc func uploadGameAction() {
        let group = DispatchGroup()
        group.notify(queue: .main) {
            print("Uploaded all successfully")
        }
        
        group.enter()
        let game = gameCreatorController.game
        gameUploadController.upload(game: game) { (error) in
            group.leave()
        }
        
        for quest in game.quests {
            group.enter()
            gameUploadController.upload(quest: quest) { (error) in
                group.leave()
            }
        }
        
    }
    @IBAction func publishButton(_ sender: UIButton) {
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
    
    private func updateWaypointInformation() {
        gameCreatorController.set(duration: 1.0)
        gameCreatorController.set(length: 1.0)
        
        let waypoints = gameCreatorController.waypoints
        routeCtrl.calculateEntireRoute(with: waypoints, transportType: .walking) { route in
            self.gameCreatorController.set(duration: route.travelTime)
            self.gameCreatorController.set(length: route.distance)
            
            let travelTimeString = self.routeCtrl.readableValue(forDistance: route.distance)
            let distanceString = self.routeCtrl.readableValue(forTravelTime: route.travelTime)
            
            self.durationLabel.text = travelTimeString
            self.lengthLabel.text = distanceString
        }
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
        navigationItem.rightBarButtonItem?.isEnabled = progress >= 1.0
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
        print("------- :)")
        gameCreatorController.set(categories: selectedCategories)
        navigationController?.popViewController(animated: true)
        
        displayCategories()
    }
}


// MARK: - CreateGameQuestOverviewCollectionViewDelegate

extension CreateGameViewController: CreateGameQuestOverviewCollectionViewDataChangedDelegate {
    
    func didMovedQuest(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath) {
        print("TODO ✅ @Patrick - Calculate new route - source: \(sourceIndexPath) - dest: \(destinationIndexPath)")
        // update methoden für Patrick
//        gameCreatorController.set(duration: 1.0)
//        gameCreatorController.set(length: 1.0)
        let tmpQuest = gameCreatorController.game.quests[destinationIndexPath.row]
        gameCreatorController.game.quests[destinationIndexPath.row] = gameCreatorController.game.quests[sourceIndexPath.row]
        gameCreatorController.game.quests[sourceIndexPath.row] = tmpQuest
        updateWaypointInformation()
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
        
        updateWaypointInformation()
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

// MARK: - Keyboard

extension CreateGameViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

