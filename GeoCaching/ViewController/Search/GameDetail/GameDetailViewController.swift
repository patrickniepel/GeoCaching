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
        descriptionLabel.text = "From the edge of the Fichtelgebirge, the Saale meanders in countless loops through Bayer to the Rhine. On its way it flows through picturesque valleys with wooded slopes, steep vineyards and rugged cliffs. On other passages, green meadows line the banks of wide fields and idyllic towns. Along the river, the Saale valley cycle path from Hof to Bayreuth covers about 370 kilometers (230 miles). On the way from its origin to the mouth of the Rhine, it flows past not only beatiful countryside, but also beautiful cities such as Oberkotzau and Neila."
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
