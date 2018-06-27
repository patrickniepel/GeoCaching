//
//  DrawQuestAreaViewController.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 17.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit
import GoogleMaps

protocol DrawQuestAreaViewControllerDelegate {
    func didAdd(locationCoordinate2D: CLLocationCoordinate2D, withRadius radius: Float)
}

class DrawQuestAreaViewController: UIViewController {
    var mapView = GMSMapView.map(withFrame: CGRect.zero, camera: GMSCameraPosition.camera(withLatitude: -33.86,
                                                                                          longitude: 151.2, zoom: 6.0))
    var userSelectedPoint: CLLocationCoordinate2D? {
        didSet {
            navigationItem.rightBarButtonItem?.isEnabled = userSelectedPoint != nil
            circleControlStackView.isHidden = false
        }
    }
    var circleControlStackView = UIStackView()
    var circleRadiusSlider = UISlider()
    var circleRadiusLabel = UILabel()
    var circle = GMSCircle()
    
    var delegate: DrawQuestAreaViewControllerDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDesign()
        setupText()
        setupData()
        setupConstraints()
    }
    
    
    // MARK: - Setup
    
    func setupText() {
        setCircleRadiusLabelText(radius: 100)
    }
    
    func setupDesign() {
        view.backgroundColor = AppColor.background
        
        self.view = mapView
        
        circleRadiusLabel.textColor = AppColor.text
        
        circleRadiusSlider.tintColor = AppColor.tint
        
        circleControlStackView.addArrangedSubview(circleRadiusSlider)
        circleControlStackView.addArrangedSubview(circleRadiusLabel)
        circleControlStackView.axis = .horizontal
        circleControlStackView.distribution = .fill
        circleControlStackView.spacing = 20.0
        circleControlStackView.isHidden = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self, action: #selector(addQuestCoordinates))
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = AppColor.tint
        
        self.view.addSubview(circleControlStackView)
    }
    
    func setupData() {
        setupMap()
        
        circleRadiusSlider.minimumValue = 25
        circleRadiusSlider.value = 100
        circleRadiusSlider.maximumValue = 1000
        
        circleRadiusSlider.addTarget(self, action: #selector(circleSliderDidMoved(_:)), for: .valueChanged)
    }
    
    private func setupMap() {
        do {
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            }
        } catch {
            print("Google-Map-JSON-Style-Error: \(error)")
        }
        
        mapView.delegate = self
    }
    
    func setupConstraints() {
        circleControlStackView.translatesAutoresizingMaskIntoConstraints = false

        let left = NSLayoutConstraint(item: circleControlStackView, attribute: .left,
                                      relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 8.0)
        let right = NSLayoutConstraint(item: circleControlStackView, attribute: .right,
                                       relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -8.0)
        let bottom = NSLayoutConstraint(item: circleControlStackView, attribute: .bottom,
                                        relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 8.0)
        let height = NSLayoutConstraint(item: circleControlStackView, attribute: .height,
                                        relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 170.0)

        self.view.addConstraints([left, right, bottom, height])
    }
    
    
    @objc func circleSliderDidMoved(_ sender: UISlider) {
        let radius = sender.value
        redrawCircleOnMap(withRadius: radius)
        setCircleRadiusLabelText(radius: radius)
    }
    
    @objc func addQuestCoordinates() {
        print("Add Quest Coordinates")
        if let userSelectedPoint = userSelectedPoint {
            let coordinate = userSelectedPoint
            let radius = Float(circle.radius)
            delegate?.didAdd(locationCoordinate2D: coordinate, withRadius: radius)
        }
    }
    
    func redrawCircleOnMap(withRadius radius: Float) {
        if let userSelectedPoint = userSelectedPoint {
            circle.map = nil
            circle = GMSCircle(position: userSelectedPoint, radius: CLLocationDistance(radius))
            circle.strokeColor = AppColor.tint
            circle.map = mapView
        }
    }
    
    func setCircleRadiusLabelText(radius: Float) {
        circleRadiusLabel.text = String(format: "%.0f Meter", arguments: [radius])
    }

}


extension DrawQuestAreaViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        userSelectedPoint = coordinate
        let radius: Float = 100
        redrawCircleOnMap(withRadius: radius)
        setCircleRadiusLabelText(radius: radius)
    }
}







