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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count + 1 // + 1 für die Add-question Celle
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isAddAnswerCell(indexPath: indexPath) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "text_input_cell", for: indexPath) as! UICreateAddQuestionTableViewCell
            
            cell.titleLabel.textColor = AppColor.text
            cell.addQuestionButton.tintColor = AppColor.tint
            cell.backgroundColor = AppColor.background
            cell.delegate = self
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "quest_overview_cell", for: indexPath)
            
            cell.backgroundColor = AppColor.background
            cell.textLabel?.text = answers[indexPath.row]
            cell.textLabel?.textColor = AppColor.text
            
            return cell
        }
    }
    
    func isAddAnswerCell(indexPath: IndexPath) -> Bool {
        return answers.count == indexPath.row
    }
}

extension CreateQuestAnswerTableViewDataSource: UICreateAddQuestionTableViewCellDelegate {
    func didEntered(answer: String, inTableView tableView: UITableView) {
        if !answer.isEmpty {
            answers.append(answer)
            let lastIndex = IndexPath(row: answers.count-1, section: 0)
            tableView.insertRows(at: [lastIndex], with: .right)
        }
    }
}
