//
//  QuestionViewController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 20.06.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var quest : Quest? = nil
    @IBOutlet weak var questionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let view = self.view.loadNib(for: "TextInputView")
        questionView.frame = view.frame
        questionView.addSubview(view)
    }
}
