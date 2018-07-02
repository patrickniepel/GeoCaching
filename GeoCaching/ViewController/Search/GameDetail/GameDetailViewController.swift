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
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
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
        imageView.image = game.image
        
        if game.name != GameSingleton.sharedInstance.weilMorgenDieAbgabeIst {
            startGameButton.isEnabled = false
            startGameButton.alpha = 0.3
        }
    }
    
    private func setupText(){
        titleLabel.text = game.name
        subtitle.text = game.shortDescription
        hashtags.text = "Rating: \(game.rating)"
        descriptionLabel.text = game.longDescription
        timeLabel.text = RouteController().readableValue(forTravelTime: game.duration)
        distanceLabel.text = RouteController().readableValue(forDistance: game.length)
        
    }
    
    private func setupDesign(){
        highscoreTableView.backgroundColor = AppColor.background
        highscoreTableView.tableFooterView = UIView(frame: .zero)
        self.view.backgroundColor = AppColor.background
        startGameButton.backgroundColor = AppColor.tint
        startGameButton.layer.cornerRadius = startGameButton.bounds.height/2
        
    }
    
    @IBAction func doIt() {
        let gameViewCtrlIndex = 1
        if let navCtrl = tabBarController?.viewControllers?[gameViewCtrlIndex] as? UINavigationController {
            if let gameVCtrl = navCtrl.viewControllers[0] as? GameViewController {
                gameVCtrl.activeGameController = ActiveGameController(game: game)
                tabBarController?.selectedIndex = gameViewCtrlIndex
            }
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
