//
//  GameDetailViewController.swift
//  GeoCaching
//
//  Created by Philipp on 23.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class GameDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var hashtags: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var highscoreTableView: UITableView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var dataSource : GameDetailHighscoreTableViewDataSource!
    var delegate : GameDetailHighscoreTableViewDelegate!
    
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
        setupText()
        setupDesign()
        dataSource = GameDetailHighscoreTableViewDataSource()
        delegate = GameDetailHighscoreTableViewDelegate()
        highscoreTableView.dataSource = dataSource
        highscoreTableView.delegate = delegate
        highscoreTableView.register(UINib(nibName: SearchIdentifiers.gameDetailHighscoreTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SearchIdentifiers.gameDetailHighscoreTableViewCell.identifier)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupData(){
    }
    
    private func setupText(){
        titleLabel.text = game.name
        descriptionLabel.text = game.longDescription
    }
    
    private func setupDesign(){
        highscoreTableView.backgroundColor = AppColor.background
        highscoreTableView.tableFooterView = UIView(frame: .zero)
        self.view.backgroundColor = AppColor.background
        startGameButton.backgroundColor = AppColor.tint
        startGameButton.layer.cornerRadius = startGameButton.bounds.height/2
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
