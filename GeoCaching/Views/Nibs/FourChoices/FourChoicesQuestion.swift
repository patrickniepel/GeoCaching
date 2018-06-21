//
//  FourChoicesQuestion.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 20.06.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class FourChoicesQuestion: QuestionView {

    @IBOutlet var questionBtnCollection: [UIButton]!
    
    override func setupLayout() {
        questionBtnCollection.forEach { btn in
            btn.layer.cornerRadius = 10
            btn.backgroundColor = AppColor.backgroundLighter2
            //btn.layer.borderWidth = 2
            btn.layer.borderColor = AppColor.tint.cgColor
            btn.setTitleColor(.white, for: .normal)
        }
        self.backgroundColor = AppColor.background
    }

    @IBAction func questionSelected(_ sender: UIButton) {
        clearAll()
        sender.backgroundColor = AppColor.tint
        
        guard let delegate = delegate else { return }
        delegate.answer("")
    }
    
    private func clearAll() {
        questionBtnCollection.forEach { btn in
            btn.backgroundColor = AppColor.backgroundLighter2
        }
    }
}
