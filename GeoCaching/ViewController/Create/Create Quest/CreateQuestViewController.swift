//
//  CreateQuestViewController.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 16.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreLocation

protocol CreateQuestDelegate {
    func didCreate(newQuest: Quest)
    func didUpdated(quest: Quest)
}

class CreateQuestViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var answerTableView: UITableView!
    @IBOutlet weak var questImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var questionTypeLabel: UILabel!
    @IBOutlet weak var addimageLabel: UILabel!
    
    @IBOutlet var labelCollection: [UILabel]!
    @IBOutlet var buttonCollection: [UIButton]!
    
    var questionType = QuestionType.fourChoices {
        didSet {
            answerTableViewDataSource.questionType = questionType
            answerTableView.reloadData()
        }
    }
    
    
    private var questImageViewImage: UIImage? = nil {
        didSet {
            questImageView.image = questImageViewImage ?? UIImage(named: "icon_image_select")
        }
    }
    
    private var answerTableViewDelegate: CreateQuestAnswerTableViewDelegate!
    private var answerTableViewDataSource: CreateQuestAnswerTableViewDataSource!
    
    private var questCreatorController: CreateQuestController!
    
    var receivedQuestToEdit: Quest? = nil
    
    var delegate: CreateQuestDelegate?

    
    deinit {
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: NSNotification.Name.didAddQuestAnswer, object: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDesign()
        setupText()
        setupData()
        setupGestures()
    }

    
    func setupText() {
        set(location: nil)
        set(questionType: questionType)
    }
    
    func setupDesign() {
        view.backgroundColor = AppColor.background
        answerTableView.backgroundColor = AppColor.background
        
        labelCollection.forEach { (label) in
            label.textColor = AppColor.text
        }
        buttonCollection.forEach { (button) in
            button.layer.cornerRadius = 10
            button.layer.borderColor = AppColor.tint.cgColor
            button.layer.borderWidth = 1
            button.tintColor = AppColor.tint
        }
        
        answerTableView.layer.cornerRadius = 10
        answerTableView.backgroundColor = AppColor.backgroundLighter
        
        
        questionTextField.layer.cornerRadius = 10
        questionTextField.layer.borderColor = AppColor.tint.cgColor
        questionTextField.layer.borderWidth = 1
        questionTextField.tintColor = AppColor.tint
        questionTextField.backgroundColor = .clear
        questionTextField.tintColor = AppColor.tint
        questionTextField.textColor = AppColor.text
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self, action: #selector(addQuestAction))
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = AppColor.tint
    }
    
    func setupData() {
        
        answerTableViewDataSource = CreateQuestAnswerTableViewDataSource(questionType: questionType)
        answerTableView.dataSource = answerTableViewDataSource
        
        answerTableViewDelegate = CreateQuestAnswerTableViewDelegate()
        answerTableView.delegate = answerTableViewDelegate
        
        questCreatorController = CreateQuestController()
        questCreatorController.delegate = self
        if let questToEdit = receivedQuestToEdit {
            questCreatorController.quest = questToEdit
            
            questionTextField.text = questToEdit.question
            answerTableViewDataSource.answers = questToEdit.answers
            questImageViewImage = questToEdit.image
        }
        
        questionTextField.addTarget(self, action: #selector(questionDidChange), for: .editingChanged)
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(didEnteredAnswer(_:)), name: NSNotification.Name.didAddQuestAnswer, object: nil)
    }
    
    func setupGestures() {
        let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageWasTapped))
        questImageView.isUserInteractionEnabled = true
        questImageView.addGestureRecognizer(imageTapGestureRecognizer)
    }
    
    @objc func addQuestAction() {
        let quest = questCreatorController.quest
        if receivedQuestToEdit == nil {
            delegate?.didCreate(newQuest: quest)
        } else {
            delegate?.didUpdated(quest: quest)
        }
    }
    
    @objc func questionDidChange() {
        if let question = questionTextField.text {
            questCreatorController.set(question: question)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc private func didEnteredAnswer(_ notification: Notification) {
        let answers = answerTableViewDataSource.answers
        questCreatorController.set(answers: answers)
    }
    
    @IBAction func changeQuestionTypeAction(_ sender: UIButton) {
        performSegue(withIdentifier: CreateStoryboardSegue.selectQuestType.identifier, sender: nil)
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CreateStoryboardSegue.addQuestArea.identifier {
            let destVCtrl = segue.destination as? DrawQuestAreaViewController
            destVCtrl?.delegate = self
        } else if segue.identifier == CreateStoryboardSegue.selectQuestType.identifier {
            let destVCtrl = segue.destination as? CreateQuestSelectQuestGameCategoryTableViewController
            destVCtrl?.receiveSelectedQuestionType = questCreatorController.quest.questionType
            destVCtrl?.delegate = self
        }
    }
    
    
    // MARK: - UI Update Stuff
    private func set(location: CLLocationCoordinate2D? = nil) {
        if location == nil {
            locationLabel.text = "Location:"
        } else {
            locationLabel.text = "Location: latitude: \(location!.latitude), longitude: \(location!.longitude)"
        }
    }
    
    private func set(questionType: QuestionType? = nil) {
        if questionType == nil {
            questionTypeLabel.text = "Questiontype:"
        } else {
            questionTypeLabel.text = "Questiontype: \(questionType!.name)"
        }
    }
    
    private func updateUI(forQuestionType questionType: QuestionType) {
        switch questionType {
        case .date: break
        case .fourChoices: break
        case .image: break
        case .number: break
        case .textInput: break
        }
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
            questCreatorController.set(image: image)
        }
        
        dismiss(animated: true)
    }
}


// MARK: - Create Quest Controller Delegate

extension CreateQuestViewController: CreateQuestControllerDelegate {
    func canCreateQuest(canCreate: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = canCreate
    }
    
    func createQuest(progress: Float) {
        print("PROGRESS: \(progress)")
        self.title = String(format: "%.0f %%", progress*100)
    }
}


// MARK: Draw Quest Area View Controller Delegate

extension CreateQuestViewController: DrawQuestAreaViewControllerDelegate {
    func didAdd(locationCoordinate2D: CLLocationCoordinate2D, withRadius radius: Float) {
        print("coordinate: \(locationCoordinate2D) - \(radius)")
        set(location: locationCoordinate2D)
        questCreatorController.set(locationPolygonPoint: locationCoordinate2D)
        questCreatorController.set(radius: Double(radius))
        navigationController?.popViewController(animated: true)
    }
}

extension CreateQuestViewController: CreateQuestSelectQuestGameCategoryTableViewControllerDelegate {
    func didSelect(questionType: QuestionType) {
        print("selectedQuestionType: \(questionType)")
        set(questionType: questionType)
        self.questionType = questionType
        questCreatorController.set(questionType: questionType)
        navigationController?.popViewController(animated: true)
    }
}

