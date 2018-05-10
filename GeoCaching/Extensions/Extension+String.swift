//
//  Extension+String.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 09.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

extension String {
    func qrCode(withScaleFactor scaleFactor: CGFloat = 1) -> UIImage? {
        let data = self.data(using: .ascii, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        
        if let ciImage = filter?.outputImage {
            let highResolutionCIImageQR = ciImage.transformed(by: CGAffineTransform(scaleX: scaleFactor, y: scaleFactor))
            return UIImage(ciImage: highResolutionCIImageQR)
        }
        return nil
    }
}

extension String {
    
    var isValidEmail: Bool{
        let emailFormat = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with:self)
    }
    
}
