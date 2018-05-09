//
//  HighscoreTableViewCell.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 09.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class HighscoreTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIProfileImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupDesign()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupDesign() {
        profileImageView.borderWidth = .thin
        
        rankLabel.layer.masksToBounds = true
        rankLabel.layer.cornerRadius = 8.0
        rankLabel.textColor = AppColor.Rank.text
    }
    
    func set(tag: Int) {
        self.tag = tag
        switch tag {
        case 0: rankLabel.backgroundColor = AppColor.Rank.rank1
        case 1: rankLabel.backgroundColor = AppColor.Rank.rank2
        case 2: rankLabel.backgroundColor = AppColor.Rank.rank3
        default: rankLabel.backgroundColor = AppColor.Rank.rank4
        }
    }

}
