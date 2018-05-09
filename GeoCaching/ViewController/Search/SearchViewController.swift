//
//  SearchViewController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 18.04.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var cardCollectionViewDelegate : CardCollectionViewDelegate!
    private var cardCollectionViewDataSource : CardCollectionViewDataSource!
    
    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    
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
        
    }
    
    func setupData() {
        
        cardCollectionViewDelegate = CardCollectionViewDelegate()
        cardCollectionViewDataSource = CardCollectionViewDataSource()
        
        cardCollectionView.dataSource = cardCollectionViewDataSource
        cardCollectionView.delegate = cardCollectionViewDelegate
        cardCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        cardCollectionView.backgroundColor = .black
    }

}
