//
//  CurrentGameViewController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 18.04.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit
import GoogleMaps


class GameViewController: UIViewController {
    @IBOutlet weak var expendableMenuButton: MenuButton!
    var mapView = GMSMapView.map(withFrame: CGRect.zero, camera: GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.2, zoom: 6.0))
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var informationBackground: UIView!
    @IBOutlet weak var informationImage: UIImageView!
    @IBOutlet weak var informationButtonOutlet: UIButton!
    
    var activeGameController: ActiveGameController! {
        didSet {
            print("GAME STARTED :)")
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
        
        setupDesign()
        setupText()
        setupData()
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
        
        
        // ###########
        informationBackground.makeButtonViewPretty()
        informationButtonOutlet.tintColor = AppColor.tint
        
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
        
        mapView.isMyLocationEnabled = true
        do {
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            }
        } catch {
            print("Google-Map-JSON-Style-Error: \(error)")
        }
        
        self.view = mapView
        self.view.addSubview(expendableMenuButton)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start Game", style: .done, target: self, action: #selector(doIt))
        
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
    }
    
    
    
    
    // MARK: - Helperfunctions
    private func setDesign(forButton button: UIButton) {
        expendableMenuButton.layer.borderColor = AppColor.tint.cgColor
        expendableMenuButton.layer.borderWidth = 2.0
    }
    
    @objc private func siwssArmyButtonAction(_ sender: UIButton) {
        if !expendableMenuButton.isRunningAnimation {
            switch sender {
            case hightButton: print("height")
            case locationButton: print("location")
            case stopwatchButton: print("stopwatch")
            case timerButton: print("timer")
            case speedButton: print("speed")
            case button6: print("button6")
            default: break
            }
            expendableMenuButton.toggle(onView: self.view)
        }
    }
}

extension GameViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                                  longitude: location.coordinate.longitude, zoom: 17.0)
            self.mapView.animate(to: camera)
            print("location: \(location)")
        }
    }
}
