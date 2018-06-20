//
//  SearchViewController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 18.04.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class SearchViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    // MARK: - Private Properties
    
    private var cardCollectionViewDelegate : CardCollectionViewDelegate!
    private var cardCollectionViewDataSource : CardCollectionViewDataSource!
    private let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.2, zoom: 6.0))
    private var testLocations : [CLLocationCoordinate2D] = [CLLocationCoordinate2D(latitude: -33.86, longitude: 151.2),CLLocationCoordinate2D(latitude: -32.86, longitude: 151.2),CLLocationCoordinate2D(latitude: -34.86, longitude: 151.2)]
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var filterBarButttonItem: UIBarButtonItem!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var gameView: GMSMapView!
    
    
    // MARK: - IBActions
    
    @IBAction func changeView(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            gameView.isHidden = true
            cardCollectionView.isHidden = false
        }else{
            gameView.isHidden = false
            cardCollectionView.isHidden = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupText()
        setupData()
        setupDesign()
        
    }
    
    // MARK: - Segues/Presentation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == SearchIdentifiers.segue2FilterPopup.identifier {
            let popoverViewController = segue.destination as! FilterPopupViewController
            popoverViewController.modalPresentationStyle = .popover
            popoverViewController.popoverPresentationController!.delegate = self
            popoverViewController.popoverPresentationController?.backgroundColor = AppColor.tint
            popoverViewController.preferredContentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height*0.3)
        } else if segue.identifier == SearchIdentifiers.segue2GameDetail.identifier {
            let destCtrl = segue.destination as! GameDetailViewController
            destCtrl.game = sender as? Game
        }
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

// MARK: - Setup

extension SearchViewController{
    
    func setupText() {
        segmentedControl.setTitle("Search", forSegmentAt: 0)
        segmentedControl.setTitle("Map", forSegmentAt: 1)
    }
    
    func setupDesign() {
        self.view.backgroundColor = AppColor.background
        filterBarButttonItem.tintColor = AppColor.tint
        segmentedControl.backgroundColor = UIColor.clear
        segmentedControl.tintColor = AppColor.tint
        cardCollectionView.backgroundColor = AppColor.background
        setupMapViewDesign()
    }
    
    func setupData() {
        
        cardCollectionViewDelegate = CardCollectionViewDelegate()
        cardCollectionViewDataSource = CardCollectionViewDataSource(games: [DummyContent.sharedInstance.universityGame])
        
        cardCollectionView.dataSource = cardCollectionViewDataSource
        cardCollectionView.delegate = cardCollectionViewDelegate
        cardCollectionViewDelegate.vc = self
        cardCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        
    }
    
}


//MARK: - GameScreen
extension SearchViewController{
    
    private func setupMapViewDesign(){
        gameView.camera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: -33.86, longitude: 151.2), zoom: 6.0)
        gameView.isHidden = true
        //Get MapViewStyle
        do {
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                gameView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            }
        } catch {
            print("Google-Map-JSON-Style-Error: \(error)")
        }
        for location in testLocations{
            let marker = GMSMarker(position: location)
            marker.title = "Event"
            marker.icon = GMSMarker.markerImage(with: AppColor.tint)
            marker.map = gameView
        }
        
    }
}
