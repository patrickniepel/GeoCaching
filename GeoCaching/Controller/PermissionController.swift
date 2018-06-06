//
//  PermissionController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 06.06.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//
import CoreLocation

struct PermissionController {
    func requestLocationTracking() {
        let locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
    }
}
