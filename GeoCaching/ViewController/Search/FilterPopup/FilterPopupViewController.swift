//
//  FilterPopupViewController.swift
//  GeoCaching
//
//  Created by Philipp on 16.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class FilterPopupViewController: UIViewController {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var delegate : FilterPopupTableViewDelegate!
    var dataSource : FilterPopupTableViewDataSource!
    
    var destinationSearch : SearchViewController?
    var desitinationHighscore : HighscoreViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupText()
        setupDesign()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupText(){
        
    }
    
    func setupData(){
        delegate = FilterPopupTableViewDelegate()
        dataSource = FilterPopupTableViewDataSource()
        if let destination = destinationSearch {
            delegate.destinationSearch = destination
            dataSource.destinationSearch = destination
        }else if let destination = desitinationHighscore {
            delegate.desitinationHighscore = destination
            dataSource.desitinationHighscore = destination
        }
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    func setupDesign(){
        tableView.backgroundColor = AppColor.background
        tableView.layer.borderWidth = 2
        tableView.layer.borderColor = AppColor.tint.cgColor
        tableView.layer.cornerRadius = 12
        self.view.backgroundColor = AppColor.background
    }
    
    @objc func dissmissCurrentVC(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.dismiss(animated: true, completion: nil)
    }

}


