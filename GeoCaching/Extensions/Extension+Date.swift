//
//  Extension+Date.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 08.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import Foundation

extension Date {
    var dateDatabaseFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        return dateFormatter.string(from: self)
    }
    
    init?(fromDatabaseFormat databaseString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        if let date = dateFormatter.date(from: databaseString) {
            self = date
        } else {
            return nil
        }
    }
}
