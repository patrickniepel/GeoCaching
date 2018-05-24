//
//  GameDetailHighscoreTableViewCell.swift
//  GeoCaching
//
//  Created by Philipp on 24.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class GameDetailHighscoreTableViewCell: UITableViewCell {

    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!{
        didSet{
            userImage.layer.cornerRadius = userImage.frame.width/2
            userImage.layer.borderWidth = 2
            userImage.layer.borderColor = AppColor.tint.cgColor
        }
    }
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
