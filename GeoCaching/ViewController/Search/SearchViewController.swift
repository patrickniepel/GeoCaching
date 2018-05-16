//
//  SearchViewController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 18.04.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    private var cardCollectionViewDelegate : CardCollectionViewDelegate!
    private var cardCollectionViewDataSource : CardCollectionViewDataSource!
    
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var filterBarButttonItem: UIBarButtonItem!
    
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
        filterBarButttonItem.tintColor = AppColor.tint
    }
    
    func setupData() {
        
        cardCollectionViewDelegate = CardCollectionViewDelegate()
        cardCollectionViewDataSource = CardCollectionViewDataSource()
        
        cardCollectionView.dataSource = cardCollectionViewDataSource
        cardCollectionView.delegate = cardCollectionViewDelegate
        cardCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        cardCollectionView.backgroundColor = .black
    }
    
    // MARK: - Segues
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
