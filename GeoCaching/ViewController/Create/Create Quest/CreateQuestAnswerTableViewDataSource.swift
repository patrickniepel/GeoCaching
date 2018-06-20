//
//  CreateQuestAnswerTableViewDataSource.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 16.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class CreateQuestAnswerTableViewDataSource: NSObject, UITableViewDataSource {
    var answers: [String] = []
    var questionType: QuestionType
    
    init(questionType: QuestionType) {
        self.questionType = questionType
        super.init()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(didEnteredAnswer(_:)), name: NSNotification.Name.didAddQuestAnswer, object: nil)
    }
    
    deinit {
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: NSNotification.Name.didAddQuestAnswer, object: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count + 1 // + 1 für die Add-question Celle
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isAddAnswerCell(indexPath: indexPath) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "text_input_cell", for: indexPath) as! UICreateAddQuestionTableViewCell
            
            cell.titleLabel.textColor = AppColor.text
            cell.addQuestionButton.tintColor = AppColor.tint
            cell.backgroundColor = .clear
            
            cell.answerInpputTextField.backgroundColor = .clear
            cell.answerInpputTextField.layer.cornerRadius = 10
            cell.answerInpputTextField.layer.borderColor = AppColor.tint.cgColor
            cell.answerInpputTextField.layer.borderWidth = 1
            cell.answerInpputTextField.tintColor = AppColor.tint
            cell.answerInpputTextField.textColor = AppColor.text
            
            switch questionType {
            case .textInput: fallthrough
            case .image: fallthrough
            case .fourChoices: cell.answerInpputTextField.keyboardType = .default
            case .number: cell.answerInpputTextField.keyboardType = .decimalPad
            case .date:
                print("Date :)")
                break
            }
            
            cell.setup()
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "quest_overview_cell", for: indexPath)
            
            cell.backgroundColor = .clear
            cell.textLabel?.text = answers[indexPath.row]
            cell.textLabel?.textColor = AppColor.text
            
            
            return cell
        }
    }
    
    func isAddAnswerCell(indexPath: IndexPath) -> Bool {
        return answers.count == indexPath.row
    }
    
    @objc private func didEnteredAnswer(_ notification: Notification) {
        if let answer = notification.userInfo?["newAnswer"] as? String,
            let tableView = notification.userInfo?["tableView"] as? UITableView {
            
            if !answer.isEmpty {
                answers.append(answer)
                // TODO: ✅🚨
//                let lastIndex = IndexPath(row: answers.count-1, section: 0)
//                tableView.insertRows(at: [lastIndex], with: .right)
                tableView.reloadData()
            }
        }
    }
}

