//
//  UIGeoButton.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 08.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class UIGeoButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        self.backgroundColor = AppColor.tint
        self.setTitleColor(AppColor.text, for: .normal)
        self.layer.cornerRadius = 10
        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: 120, height: 35)
    }
    
}
