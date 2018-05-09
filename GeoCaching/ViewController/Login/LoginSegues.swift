//
//  LoginSegues.swift
//  GeoCaching
//
//  Created by Carl Philipp Knoblauch on 09.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import Foundation

enum LoginStoryboardSegue {
    case register
    
    
    var identifier: String {
        switch self {
        case .register : return "loginSegueRegister"
        }
    }
}
