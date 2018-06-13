//
//  UICreateAddQuestionTableViewCell.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 16.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class UICreateAddQuestionTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var answerInpputTextField: UITextField!
    @IBOutlet weak var addQuestionButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setup() {
        addQuestionButton.layer.borderWidth = 1
        addQuestionButton.layer.borderColor = AppColor.tint.cgColor
        addQuestionButton.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addAnswerAction(_ sender: UIButton) {
        if let answer = answerInpputTextField.text, let tableView = self.superview as? UITableView {
            let nc = NotificationCenter.default
            nc.post(name: NSNotification.Name.didAddQuestAnswer, object: self, userInfo: ["newAnswer":answer,
                                                                                          "tableView": tableView])
        }
        answerInpputTextField.text = ""
    }
}
