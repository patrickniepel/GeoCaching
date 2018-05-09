//
//  AppColor.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 09.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

struct AppColor {
    private init() {}
    static var background = UIColor(red: 33, green: 33, blue: 33, alpha: 1.0)
    static var text = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
    static var tint = UIColor(red: 246, green: 182, blue: 66, alpha: 1.0)
    static var navigationBar = UIColor(red: 60, green: 60, blue: 60, alpha: 1.0)
    
    static var wrong = UIColor(red: 209, green: 72, blue: 65, alpha: 1.0)
    static var right = UIColor(red: 65, green: 168, blue: 95, alpha: 1.0)
    static var banner = UIColor(red: 243, green: 121, blue: 52, alpha: 1.0)
    
    struct Rank {
        private init() {}
        static var rank1 = UIColor(red: 246, green: 182, blue: 66, alpha: 1.0)
        static var rank2 = UIColor(red: 167, green: 124, blue: 45, alpha: 1.0)
        static var rank3 = UIColor(red: 128, green: 108, blue: 72, alpha: 1.0)
        static var rank4 = UIColor(red: 166, green: 166, blue: 166, alpha: 1.0)
        static var text = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
    }
}
