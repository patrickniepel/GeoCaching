//
//  NumberQuestion.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 20.06.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class NumberQuestion: QuestionView {

    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var answerTextField: UITextField!
    
    override func setupLayout() {
        self.backgroundColor = AppColor.background
        textFieldView.backgroundColor = AppColor.backgroundLighter2
        textFieldView.layer.cornerRadius = 10
        textFieldView.layer.borderWidth = 2
        textFieldView.layer.borderColor = AppColor.tint.cgColor
        
        answerTextField.placeholder = "Your Answer"
    }
    
    
    @IBAction func inputChanged(_ sender: UITextField) {
        guard let delegate = delegate else { return }
        
        //Nichts eingetragen
        if sender.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            return
        }
        
        guard let answerText = sender.text else { return }
        
        delegate.answer(answerText)
    }
}
