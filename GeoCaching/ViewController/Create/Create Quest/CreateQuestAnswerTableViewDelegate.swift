//
//  CreateQuestAnswerTableViewDelegate.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 16.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class CreateQuestAnswerTableViewDelegate: NSObject, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let dSource = tableView.dataSource as? CreateQuestAnswerTableViewDataSource {
            if dSource.isAddAnswerCell(indexPath: indexPath) {
                return 86.0
            }
        }
        return 44.0
    }
}
