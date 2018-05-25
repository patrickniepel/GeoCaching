//
//  SelectQuestGameCategoryTableViewController.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 25.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit


protocol CreateQuestSelectQuestGameCategoryTableViewControllerDelegate {
    func didSelect(questionType: QuestionType)
}

class CreateQuestSelectQuestGameCategoryTableViewController: UITableViewController {
    
    var delegate: CreateQuestSelectQuestGameCategoryTableViewControllerDelegate?
    
    private var questTypes = QuestionType.allCases
    var receiveSelectedQuestionType: QuestionType = .image

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDesign()
        setupText()
        setupData()
    }
    
    func setupDesign() {
        view.backgroundColor = AppColor.background
    }
    
    func setupText() {
    }
    
    func setupData() {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questTypes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = AppColor.background
        cell.textLabel?.textColor = AppColor.text
        cell.tintColor = AppColor.tint

        let questType = getQuestionType(atIndexPath: indexPath)
        cell.textLabel?.text = questType.name
        
        if questType.name == receiveSelectedQuestionType.name {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
    
    private func getQuestionType(atIndexPath indexPath: IndexPath) -> QuestionType {
        return questTypes[indexPath.row]
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedQuestionType = getQuestionType(atIndexPath: indexPath)
        delegate?.didSelect(questionType: selectedQuestionType)
    }
}
