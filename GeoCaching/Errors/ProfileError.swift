//
//  ProfileError.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 08.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import Foundation

enum ProfileError: Error {
    case failedFetchingProfile
    case userNotFound
    
    var localizedDescription: String {
        switch self {
        case .failedFetchingProfile: return "A profile error occured."
        case .userNotFound: return "User not found."
        }
    }
}
