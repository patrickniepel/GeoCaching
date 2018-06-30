//
//  RatingView.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 27.06.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class RatingView: RatingQRView {
    
    @IBOutlet weak var gratulationsTitle: UILabel!
    @IBOutlet weak var gratulationsMessage: UILabel!
    @IBOutlet weak var rateThisTourLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func setupLayout() {
        self.backgroundColor = AppColor.background
        gratulationsTitle.textColor = .white
        
        gratulationsMessage.textColor = .white
        gratulationsMessage.numberOfLines = 0
        gratulationsMessage.text = "You are one of the few that have made it this far!"
        
        scoreLabel.textColor = .white
        scoreLabel.text = "Your score: \(userPoints)"
        
        rateThisTourLabel.textColor = .white
        
        valueLabel.textColor = AppColor.tint
        
        slider.value = 0
        slider.minimumValue = 0
        slider.maximumValue = 5
        slider.thumbTintColor = AppColor.tint
        slider.minimumTrackTintColor = AppColor.tint
        slider.maximumTrackTintColor = .white
        
        //Initial value for current rating
        game?.ratings.append(0)
        valueLabel.text = "\(game!.rating)"
    }
    
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        
        //Exchange old value with new one
        game?.ratings.removeLast()
        
        let sliderValue = Int(sender.value)
        game?.ratings.append(sliderValue)
        
        valueLabel.text = "\(game!.rating)"
    }
}
