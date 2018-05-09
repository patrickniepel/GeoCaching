//
//  UIProfileImageView.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 09.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class UIProfileImageView: UIImageView {
    var borderWidth = BorderWidth.big {
        didSet {
            redraw()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDesign()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDesign()
    }
    
    private func setupDesign() {
        self.layer.cornerRadius = self.frame.height / 2.0
        self.layer.borderColor = AppColor.tint.cgColor
        self.layer.borderWidth = borderWidth.value
    }
    
    func redraw() {
        setupDesign()
    }
    
    enum BorderWidth {
        case thin
        case small
        case big
        
        var value: CGFloat {
            switch self {
            case .thin: return 1.5
            case .small: return 3.0
            case .big: return 5.0
            }
        }
    }
}
