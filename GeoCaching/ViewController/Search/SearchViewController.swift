//
//  SearchViewController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 18.04.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    // MARK: - Private Properties
    
    private var cardCollectionViewDelegate : CardCollectionViewDelegate!
    private var cardCollectionViewDataSource : CardCollectionViewDataSource!
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var filterBarButttonItem: UIBarButtonItem!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: - IBActions
    
    @IBAction func changeSearchScreen(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupText()
        setupData()
        setupDesign()
        
    }
    
    // MARK: - Segues/Presentation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == SearchIdentifiers.segue2FilterPopup.identifier{
            let popoverViewController = segue.destination as! FilterPopupViewController
            popoverViewController.modalPresentationStyle = .popover
            popoverViewController.popoverPresentationController!.delegate = self
            popoverViewController.popoverPresentationController?.backgroundColor = AppColor.tint
            popoverViewController.preferredContentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height*0.3)
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
    }
    
    func setupData() {
        
        cardCollectionViewDelegate = CardCollectionViewDelegate()
        cardCollectionViewDataSource = CardCollectionViewDataSource()
        
        cardCollectionView.dataSource = cardCollectionViewDataSource
        cardCollectionView.delegate = cardCollectionViewDelegate
        cardCollectionViewDelegate.vc = self
        cardCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        
    }
    
}
