//
//  AuthError.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 08.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import Foundation

enum AuthError: Error {
    case error
    case unknown
    case usernameInUse
    
    var localizedDescription: String {
        switch self {
        case .error: return "A auth error occured."
        case .unknown: return "A unknown error occured."
        case .usernameInUse: return "The username is already in use by another account."
        }
    }
}
