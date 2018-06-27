//
//  QuestionViewController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 20.06.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, QuestionAnswerDelegate {
    
    var activeGameCtrl: ActiveGameController! {
        didSet {
            questionType = activeGameCtrl.currentQuest.questionType
        }
    }
    
    lazy var questionType : QuestionType? = nil
    //var type : QuestionType = .textInput
    
    lazy var userAnswerCurrentQuestion: String? = nil
    
    var activeGameDelegate: ActiveGameDelegate? = nil
    
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
        questionText.numberOfLines = 2
        
        answerQuestionBtn.setTitleColor(AppColor.tint, for: .normal)
        answerQuestionBtn.layer.borderColor = AppColor.tint.cgColor
        answerQuestionBtn.layer.borderWidth = 2
        answerQuestionBtn.layer.cornerRadius = 10
    }
    
    private func loadQuestionType() {
        
        guard let type = questionType else { return }
        
        var questionView = QuestionView()
        
        switch type {
        case .textInput:
            questionView = UINib(nibName: "TextInputView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! TextInputQuestion
        case .fourChoices:
            questionView = UINib(nibName: "FourChoicesView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! FourChoicesQuestion
        case .date:
            questionView = UINib(nibName: "DateView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! DateQuestion
        case .number:
            questionView = UINib(nibName: "NumberView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! NumberQuestion
        case .image:
            questionView = UINib(nibName: "ImageView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! ImageQuestion
        }
        
        prepareQuestInfos(view: questionView)
        questionTypeView.bounds = questionView.bounds
        questionTypeView.addSubview(questionView)
    }
    
    private func prepareQuestInfos(view: QuestionView) {
        questionTitle.text = "Question \(activeGameCtrl.currentQuestIndex + 1)"
        questionText.text = activeGameCtrl.currentQuest.question
        view.quest = activeGameCtrl.currentQuest
        view.delegate = self
        view.setupLayout()
    }
    
    /** Checks if answer is correct */
    @IBAction func answerQuestion(_ sender: UIButton) {
        
        guard let delegate = activeGameDelegate else { return }
        
        var alertForUser: UIAlertController!
        
        // Anwort ausgewählt bzw Antwort eingegeben
        if let userAnswer = userAnswerCurrentQuestion {
            let answerCorrect = activeGameCtrl?.isUserAnswerCorrect(userAnswer: userAnswer)
            
            guard let isCorrect = answerCorrect else { return }
            
            if isCorrect {
                alertForUser = alert(for: "Gratulations", message: "Your Answer Is Correct", actionText: "Continue", delegate: delegate, vc: self)
            }
            else {
                alertForUser = alert(for: "Sorry", message: "Your Answer Is Wrong", actionText: "Continue", delegate: delegate, vc: self)
            }
        }
        // Antwort noch nicht hinzufügen
        else {
            alertForUser = alert(for: "No Answer", message: "Select An Answer To Continue", actionText: "OK")
        }
        
        self.present(alertForUser, animated: true)
    }
    
    /** Gets Answer from question screen */
    func answer(_ answer: String) {
        userAnswerCurrentQuestion = answer
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
