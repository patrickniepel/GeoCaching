//
//  FilterPopupViewController.swift
//  GeoCaching
//
//  Created by Philipp on 16.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class FilterPopupViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var delegate : FilterPopupTableViewDelegate!
    var dataSource : FilterPopupTableViewDataSource!
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = FilterPopupTableViewDelegate()
        dataSource = FilterPopupTableViewDataSource()
        tableView.delegate = self.delegate
        tableView.dataSource = self.dataSource
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


