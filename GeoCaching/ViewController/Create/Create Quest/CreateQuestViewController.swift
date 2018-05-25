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
    }
    
    func setupDesign() {
        view.backgroundColor = AppColor.background
        questionLabel.textColor = AppColor.text
        answersLabel.textColor = AppColor.text
        answerTableView.backgroundColor = AppColor.background
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self, action: #selector(addQuestAction))
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = AppColor.tint
    }
    
    func setupData() {
        answerTableViewDataSource = CreateQuestAnswerTableViewDataSource()
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
        questCreatorController.set(locationPolygonPoints: [locationCoordinate2D])
        navigationController?.popViewController(animated: true)
    }
}

extension CreateQuestViewController: CreateQuestSelectQuestGameCategoryTableViewControllerDelegate {
    func didSelect(questionType: QuestionType) {
        print("selectedQuestionType: \(questionType)")
        questCreatorController.set(questionType: questionType)
        navigationController?.popViewController(animated: true)
    }
}

