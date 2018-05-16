//
//  UICreateAddQuestionTableViewCell.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 16.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

protocol UICreateAddQuestionTableViewCellDelegate {
    func didEntered(answer: String, inTableView tableView: UITableView)
}

class UICreateAddQuestionTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var answerInpputTextField: UITextField!
    @IBOutlet weak var addQuestionButton: UIButton!
    
    var delegate: UICreateAddQuestionTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addAnswerAction(_ sender: UIButton) {
        print("add question action")
        if let answer = answerInpputTextField.text, let tableView = self.superview as? UITableView {
            print("\(self.superview)")
            delegate?.didEntered(answer: answer, inTableView: tableView)
        }
        answerInpputTextField.text = ""
    }
}
