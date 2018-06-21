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
    
    override func setupLayout() {
        self.backgroundColor = AppColor.background
        textFieldView.backgroundColor = AppColor.backgroundLighter2
        textFieldView.layer.cornerRadius = 10
        textFieldView.layer.borderWidth = 2
        textFieldView.layer.borderColor = AppColor.tint.cgColor
    }
    
    
    @IBAction func inputChanged(_ sender: UITextField) {
        guard let delegate = delegate else { return }
        delegate.answer("")
    }
}
