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
    
    override func setupLayout() {
        self.backgroundColor = AppColor.background
        gratulationsTitle.textColor = .white
        
        gratulationsMessage.textColor = .white
        gratulationsMessage.numberOfLines = 0
        gratulationsMessage.text = "Gratulations!\nYou are one of the few that have made it this far."
        
        rateThisTourLabel.textColor = .white
        
        valueLabel.textColor = AppColor.tint
        valueLabel.text = "1"
        
        slider.thumbTintColor = AppColor.tint
        slider.minimumTrackTintColor = AppColor.tint
        slider.maximumTrackTintColor = .white
    }
    
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        guard let delegate = delegate else { return }
        valueLabel.text = "\(Int(sender.value))"
        delegate.changedSliderValue(sliderValue: Int(sender.value))
    }
}
