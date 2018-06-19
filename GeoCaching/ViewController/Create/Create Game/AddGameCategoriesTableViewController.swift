//
//  AddGameCategoriesTableViewController.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 23.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

protocol AddGameCategoriesDelegate: class {
    func receive(selectedCategories: [QuestCategory])
}

class AddGameCategoriesTableViewController: UITableViewController {
    
    private var categories = QuestCategory.allCases
    var selectedCategories: Set<QuestCategory> = []
    
    var delegate: AddGameCategoriesDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("------ heeeeelllo. \(delegate)")
        
        setupDesign()
        setupText()
        setupData()
    }
    
    
    // MARK: - Setup
    
    func setupText() {
    }
    
    func setupDesign() {
        view.backgroundColor = AppColor.background
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self,
                                                            action: #selector(didPressedSaveAction))
        navigationItem.rightBarButtonItem?.tintColor = AppColor.tint
    }
    
    func setupData() {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = AppColor.background
        cell.textLabel?.textColor = AppColor.text
        cell.tintColor = AppColor.tint

        let category = getCategory(atIndexPath: indexPath)
        cell.textLabel?.text = category.name
        
        cell.accessoryType = (selectedCategories.contains(category)) ? .checkmark : .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = getCategory(atIndexPath: indexPath)
        
        if !selectedCategories.contains(selectedCategory) {
            selectedCategories.insert(selectedCategory)
        } else {
            selectedCategories.remove(selectedCategory)
        }
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    
    // MARK: - Hilfsmethoden
    
    private func getCategory(atIndexPath indexPath: IndexPath) -> QuestCategory {
        return categories[indexPath.row]
    }
    
    @objc private func didPressedSaveAction() {
        let selectedQuestCategories = Array(selectedCategories).sorted { (quest1, quest2) -> Bool in
            return quest1.name < quest2.name
        }
        delegate?.receive(selectedCategories: selectedQuestCategories)
    }

}
