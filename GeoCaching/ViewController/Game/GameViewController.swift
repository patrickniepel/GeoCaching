//
//  CurrentGameViewController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 18.04.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit
import GoogleMaps

enum SwissArmy {
    case height
    case location
    case stopwatch
    case timer
    case speed
    case none
}

protocol ActiveGameDelegate {
    func userAnsweredQuestion(vc: QuestionViewController)
}

class GameViewController: UIViewController {
    @IBOutlet weak var swissView: UIView!
    @IBOutlet weak var swissViewLabel: UILabel!
    
    var swissArmyElement = SwissArmy.none
    
    @IBOutlet weak var expendableMenuButton: MenuButton!
    
    var locationManager = CLLocationManager()
    private var hasZoomedToLocationOnAppStart = false
    
    @IBOutlet weak var informationBackground: UIView!
    @IBOutlet weak var informationImage: UIImageView!
    @IBOutlet weak var informationButtonOutlet: UIButton!
    
    @IBOutlet weak var theMapView: GMSMapView!
    
    var activeGameController: ActiveGameController! {
        didSet {
            print("GAME STARTED :)")
            drawLocationsInMap()
        }
    }
    
    func drawLocationsInMap() {
        let allGameQuests = activeGameController.game.quests
        let allLocations = allGameQuests.compactMap { $0.locationPolygonPoint }
        let currentQuestIndex = activeGameController.currentQuestIndex
        
        theMapView.clear()
        
        for (index, location) in allLocations.enumerated() {
            if currentQuestIndex == index {
                let radius = activeGameController.currentQuest.radius
                var circle = GMSCircle()
                circle.map = nil
                circle = GMSCircle(position: location, radius: CLLocationDistance(radius))
                circle.strokeWidth = 3.0
                circle.map = theMapView
                circle.fillColor = AppColor.tint.withAlphaComponent(0.2)
                circle.strokeColor = AppColor.tint
            } else {
                let marker = GMSMarker(position: location)
                marker.title = "\(index + 1)"
                marker.icon = GMSMarker.markerImage(with: AppColor.marker)
                marker.map = theMapView
            }
        }
    }
    
    let hightButton = UIButton()
    let locationButton = UIButton()
    let stopwatchButton = UIButton()
    let timerButton = UIButton()
    let speedButton = UIButton()
    let button6 = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Test-Segue für QuestionScreen
//        performSegue(withIdentifier: GameSegues.displayQuestion.identifier, sender: nil)
        
            
        swissView.isHidden = true
        
        setupDesign()
        setupText()
        setupData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == GameSegues.displayQuestion.identifier {
            
            let destVC = segue.destination as! QuestionViewController
            destVC.activeGameCtrl = activeGameController
            destVC.activeGameDelegate = self
            print("ActiveGameCtrl", activeGameController.currentQuest)
        }
    }
    
    
    // MARK: - Setup
    
    func setupText() {
        
    }
    
    func setupDesign() {
        hightButton.setImage(UIImage(named: "icon_hight"), for: .normal)
        locationButton.setImage(UIImage(named: "icon_location"), for: .normal)
        stopwatchButton.setImage(UIImage(named: "icon_stopwatch"), for: .normal)
        timerButton.setImage(UIImage(named: "icon_timer"), for: .normal)
        speedButton.setImage(UIImage(named: "icon_speed"), for: .normal)
        button6.setImage(UIImage(named: ""), for: .normal)
        
        swissViewLabel.numberOfLines = 2
        swissViewLabel.adjustsFontSizeToFitWidth = true
        swissViewLabel.textColor = AppColor.text
        
        swissView.backgroundColor = AppColor.background
        swissView.layer.cornerRadius = 20
        swissView.layer.borderColor = AppColor.tint.cgColor
        swissView.layer.borderWidth = 4.0
        
        
        // ###########
        informationBackground.makeButtonViewPretty()
        informationButtonOutlet.tintColor = AppColor.tint
        //informationBackground.isHidden = true
        
        expendableMenuButton.backgroundColor = AppColor.background
        expendableMenuButton.tintColor = AppColor.tint
        expendableMenuButton.layer.cornerRadius = expendableMenuButton.frame.width/2
        expendableMenuButton.setImage(UIImage(named: "icons8-swiss_army_knife"), for: .normal)
        expendableMenuButton.startFromPoint = self.view.center
        expendableMenuButton.endAtPoint = expendableMenuButton.center
        expendableMenuButton.expandingDirection = .top
        expendableMenuButton.expandingViewsSpaceInDegree = 60.0
        expendableMenuButton.expandingViewsMenu = [hightButton, locationButton, stopwatchButton,
                                                   timerButton, speedButton, button6]
        setDesign(forButton: expendableMenuButton)
        
        theMapView.isMyLocationEnabled = true
        do {
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                theMapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            }
        } catch {
            print("Google-Map-JSON-Style-Error: \(error)")
        }
        
//        theMapView = GMSMapView.map(withFrame: CGRect.zero, camera: GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.2, zoom: 6.0))
        self.view.addSubview(expendableMenuButton)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start Game", style: .done, target: self, action: #selector(doIt))
        
        informationBackground.backgroundColor = AppColor.background
        updateUI(forLocation: nil)
    }
    
    @objc func doIt() {
        print("Game start :)")
        let game = DummyContent.sharedInstance.universityGame
        activeGameController = ActiveGameController(game: game)
    }
    
    func setupData() {
        hightButton.addTarget(self, action: #selector(siwssArmyButtonAction(_:)), for: .touchUpInside)
        locationButton.addTarget(self, action: #selector(siwssArmyButtonAction(_:)), for: .touchUpInside)
        stopwatchButton.addTarget(self, action: #selector(siwssArmyButtonAction(_:)), for: .touchUpInside)
        timerButton.addTarget(self, action: #selector(siwssArmyButtonAction(_:)), for: .touchUpInside)
        speedButton.addTarget(self, action: #selector(siwssArmyButtonAction(_:)), for: .touchUpInside)
        button6.addTarget(self, action: #selector(siwssArmyButtonAction(_:)), for: .touchUpInside)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    
    // MARK: - IBActions
    
    @IBAction func menuButtonAction(_ sender: MenuButton) {
        sender.toggle(onView: view)
    }
    
    @IBAction func informationButton(_ sender: UIButton) {
        performSegue(withIdentifier: GameSegues.displayQuestion.identifier, sender: nil)
        print("--- Patrick")
    }
    
    
    // MARK: - Helperfunctions
    private func setDesign(forButton button: UIButton) {
        expendableMenuButton.layer.borderColor = AppColor.tint.cgColor
        expendableMenuButton.layer.borderWidth = 2.0
    }
    
    
    // MARK: Swiss Army Stuff
    
    @objc private func siwssArmyButtonAction(_ sender: UIButton) {
        if !expendableMenuButton.isRunningAnimation {
            showSwissArmyView()
            switch sender {
            case hightButton:
                swissArmyElement = .height
                print("height")
            case locationButton:
                swissArmyElement = .location
                print("location")
            case stopwatchButton:
                swissArmyElement = .stopwatch
                swissViewLabel.text = "Coming with Update 2.0"
                print("stopwatch")
            case timerButton:
                swissArmyElement = .timer
                swissViewLabel.text = "Coming with Update 2.0"
                print("timer")
            case speedButton:
                swissArmyElement = .speed
                print("speed")
            case button6:
                swissViewLabel.text = "Coming with Update 2.0"
                print("button6")
            default:
                swissArmyElement = .none
                closeSwissArmyView()
            }
            expendableMenuButton.toggle(onView: self.view)
        }
    }
    
    @IBAction func siwssViewCloseAction(_ sender: UIButton) {
        closeSwissArmyView()
    }
    
    private func closeSwissArmyView() {
        UIView.animate(withDuration: 1.0, animations: {
            self.swissView.alpha = 0.0
        }) { (completed) in
            self.swissView.isHidden = completed
        }
    }
    
    private func showSwissArmyView() {
        self.swissView.isHidden = false
        UIView.animate(withDuration: 1.0) {
            self.swissView.alpha = 1.0
        }
    }
    
}

extension GameViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                                  longitude: location.coordinate.longitude, zoom: 17.0)
            if theMapView != nil {
                if !hasZoomedToLocationOnAppStart {
                    self.theMapView.animate(to: camera)
                    hasZoomedToLocationOnAppStart = true
                }
            }
            print("location: \(location)")
            
            switch swissArmyElement {
            case .location:
                let str = "lat: \(location.coordinate.latitude)\nlng: \(location.coordinate.longitude)"
                swissViewLabel.text = str
            case .speed:
                let str = "Speed: \(location.speed)"
                swissViewLabel.text = str
            case .height:
                let str = "Altitude: \(String(format: "%.1f", arguments: [Double(location.altitude)])) m"
                swissViewLabel.text = str
            default: break
            }
            
            updateUI(forLocation: location.coordinate)
        }
    }
    
    func updateUI(forLocation location: CLLocationCoordinate2D?) {
        guard let location = location else {
            informationBackground.layer.borderColor = AppColor.backgroundLighter2.cgColor
            informationButtonOutlet.isUserInteractionEnabled = false
            informationButtonOutlet.setTitleColor(AppColor.backgroundLighter2, for: .normal)
            return
        }
        if activeGameController != nil {
            if activeGameController.isUserAllowedToAnswerTheQuest(userLocation: location) {
                informationBackground.layer.borderColor = AppColor.tint.cgColor
                informationButtonOutlet.isUserInteractionEnabled = true
                informationButtonOutlet.setTitleColor(AppColor.tint, for: .normal)
            } else {
                informationBackground.layer.borderColor = AppColor.backgroundLighter2.cgColor
                informationButtonOutlet.isUserInteractionEnabled = false
                informationButtonOutlet.setTitleColor(AppColor.backgroundLighter2, for: .normal)
            }
            let buttonTitle = "Questinformation \(activeGameController.currentQuestIndex + 1)"
            informationButtonOutlet.setTitle(buttonTitle, for: .normal)
        }
    }
}


extension GameViewController: ActiveGameDelegate {
    
    func userAnsweredQuestion(vc: QuestionViewController) {
        vc.dismiss(animated: true, completion: nil)
        activeGameController.nextQuest()
        drawLocationsInMap()
        
        informationBackground.layer.borderColor = AppColor.backgroundLighter2.cgColor
        informationButtonOutlet.isUserInteractionEnabled = false
        informationButtonOutlet.setTitleColor(AppColor.backgroundLighter2, for: .normal)
    }
}



