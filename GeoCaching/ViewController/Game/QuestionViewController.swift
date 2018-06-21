//
//  QuestionViewController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 20.06.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, QuestionAnswerDelegate {
    
    var activeGameCtrl: ActiveGameController? = nil {
        didSet {
            questionType = activeGameCtrl?.currentQuest.questionType
        }
    }
    
    lazy var questionType : QuestionType? = nil
    //var type : QuestionType = .textInput
    
    lazy var userAnswerCurrentQuestion: String? = nil
    
    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var questionText: UILabel!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var answerQuestionBtn: UIButton!
    
    @IBOutlet weak var questionTypeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadQuestionType()
    }
    
    private func setupLayout() {
        questionImage.clipsToBounds = true
        questionImage.image = #imageLiteral(resourceName: "yoga")
        questionImage.contentMode = .scaleAspectFill
        
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.masksToBounds = true
        backgroundView.backgroundColor = AppColor.background
        
        questionTitle.textColor = .white
        questionText.textColor = .white
        
        answerQuestionBtn.setTitleColor(AppColor.tint, for: .normal)
        answerQuestionBtn.layer.borderColor = AppColor.tint.cgColor
        answerQuestionBtn.layer.borderWidth = 2
        answerQuestionBtn.layer.cornerRadius = 10
    }
    
    private func loadQuestionType() {
        
        guard let type = questionType else { return }
        
        var view = QuestionView()
        
        switch type {
        case .textInput:
            view = UINib(nibName: "TextInputView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! TextInputQuestion
        case .fourChoices:
            view = UINib(nibName: "FourChoicesView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! FourChoicesQuestion
        case .date:
            view = UINib(nibName: "DateView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! DateQuestion
        case .number:
            view = UINib(nibName: "NumberView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! NumberQuestion
        case .image:
            view = UINib(nibName: "ImageView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! ImageQuestion
        }
        
        view.quest = activeGameCtrl?.currentQuest
        view.delegate = self
        view.setupLayout()
        questionTypeView.bounds = view.bounds
        questionTypeView.addSubview(view)
    }
    
    /** Checks if answer is correct */
    @IBAction func answerQuestion(_ sender: UIButton) {
        
        var alertForUser: UIAlertController!
        
        // Anwort ausgewählt bzw Antwort eingegeben
        if let userAnswer = userAnswerCurrentQuestion {
            activeGameCtrl?.currentQuest.answers.append(userAnswer)
            alertForUser = alert(for: "No Answer", message: "Select An Answer To Continue", actionText: "OK", useDelegate: true)
        }
        // Antwort noch nicht hinzufügen
        else {
            alertForUser = alert(for: "No Answer", message: "Select An Answer To Continue", actionText: "OK", useDelegate: false)
        }
        
        self.present(alertForUser, animated: true)
    }
    
    /** Gets Answer from question screen */
    func answer(_ answer: String) {
        userAnswerCurrentQuestion = answer
    }
    
    
    
}
