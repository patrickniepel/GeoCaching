//
//  Extension+UIView.swift
//  GeoCaching
//
//  Created by Carl Philipp Knoblauch on 30.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

extension UIView {
    
    func makeButtonViewPretty() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.layer.borderColor = AppColor.tint.cgColor
        self.backgroundColor = .clear
    }
    
    func loadNib(for name: String) -> UIView {
        let nib = UINib(nibName: name, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
