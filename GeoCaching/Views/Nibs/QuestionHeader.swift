//
//  QuestionHeader.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 20.06.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class QuestionHeader: UIView {
    
    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var questionText: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
        questionImage.clipsToBounds = true
        questionImage.contentMode = .scaleAspectFill
        questionImage.layer.cornerRadius = 15
        questionTitle.text = "DAS ist ein TEXT"
    }

}
