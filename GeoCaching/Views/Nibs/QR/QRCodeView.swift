//
//  QRCodeView.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 27.06.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class QRCodeView: RatingQRView {
    
    @IBOutlet weak var yourCouponLabel: UILabel!
    @IBOutlet weak var qrCodeImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setupLayout() {
        self.backgroundColor = AppColor.background
        yourCouponLabel.textColor = .white
        qrCodeImageView.image = "Hello World".qrCode(withScaleFactor: 20)
    }
}
