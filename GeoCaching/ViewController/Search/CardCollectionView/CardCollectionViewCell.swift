//
//  CardCollectionViewCell.swift
//  GeoCaching
//
//  Created by Philipp on 09.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var firstIconImageView: UIImageView!
    @IBOutlet weak var firstIconLabel: UILabel!
    @IBOutlet weak var secondIconImageView: UIImageView!
    @IBOutlet weak var secondIconLabel: UILabel!
    @IBOutlet weak var cardTitleLabel: UILabel!
    @IBOutlet weak var cardDescriptionLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    

}
