//
//  RouteController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 23.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

struct RouteController {
    
    private var directionValues = [String : String]()
    private var distance : Double = 0
    private var travelTime : Double = 0
    
    /** Returns a dictionary with values for the keys 'travelTime' and 'distance' */
    mutating func calculateRoute(with locations: [CLLocationCoordinate2D], transportType: MKDirectionsTransportType) -> [String : String] {
        
        var locations = locations
        
        if locations.count <= 1 {
            directionValues["distance"] = getCorrectValue(distance: distance)
            directionValues["travelTime"] = getCorrectValue(travelTime: travelTime)
            return directionValues
        }
        
        let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: locations.first!, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: locations[locations.index(after: locations.startIndex)], addressDictionary: nil))
        request.requestsAlternateRoutes = false
        request.transportType = transportType
        
        let direction = MKDirections(request: request)
        
        //keys -> travelTime, distance
       
        
        direction.calculate { (calculatedResponse, fetchedError) in
            
            guard let response = calculatedResponse else { print("Error: -- RouteController -- calculateRoute -- Response"); return }
            
            if (response.routes.count > 0) {
                
                guard let distanceUnwrapped = response.routes.first?.distance, let travelTimeUnwrapped = response.routes.first?.expectedTravelTime else {
                    print("Error: -- RouteController -- calculateRoute -- Distance/TravelTime")
                    return
                }
                
                self.distance += distanceUnwrapped
                self.travelTime += travelTimeUnwrapped
            }
        }
        
        locations.removeFirst()
        return calculateRoute(with: locations, transportType: transportType)
    }
    
    private func getCorrectValue(distance: CLLocationDistance) -> String {
        return distance < 1000 ? "\(distance) m" : "\(distance / 1000) km"
    }
    
    private func getCorrectValue(travelTime: TimeInterval) -> String {
        return travelTime < 60 ? "\(travelTime) s" : travelTime < 3600 ? "\(travelTime / 60) min" : "\(travelTime / 60 / 60) h"
    }
}
