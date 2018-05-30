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

class RouteController {
    
    /** Returns distance and travelTime for entire route */
    func calculateEntireRoute(with locations: [CLLocationCoordinate2D], transportType: MKDirectionsTransportType, completion: @escaping (String, String) -> ()) {
        
        var distance : Double = 0
        var travelTime : Double = 0
        
        let request = MKDirectionsRequest()
        request.requestsAlternateRoutes = false
        request.transportType = transportType
        
        let routeCreationGroup = DispatchGroup()
        
        //Combines all routes to a entire route
        for i in 0..<locations.count - 1 {

            let source = locations[locations.index(i, offsetBy: 0)]
            let destination = locations[locations.index(i, offsetBy: 1)]
            
            routeCreationGroup.enter()
            
            calculateSingleRoute(request: request, from: source, to: destination) { (dist, time) in
                distance += dist
                travelTime += time
                routeCreationGroup.leave()
            }
        }
        
        routeCreationGroup.notify(queue: DispatchQueue.main) {
          
            let distanceToPresent = self.getCorrectValue(distance: distance)
            let travelTimeToPresent = self.getCorrectValue(travelTime: travelTime)
            completion(distanceToPresent, travelTimeToPresent)
        }
    }
    
    /** Creates a route between two coordinates */
    private func calculateSingleRoute(request: MKDirectionsRequest, from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping (Double, Double) -> ()) {
        
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: source, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination, addressDictionary: nil))
        
        let direction = MKDirections(request: request)
        
        var distance : Double = 0
        var travelTime : Double = 0

        direction.calculate { (calculatedResponse, fetchedError) in
            
            guard let response = calculatedResponse else { print("Error: -- RouteController -- calculateRoute -- Response"); return }
            
            if (response.routes.count > 0) {
                
                guard let distanceUnwrapped = response.routes.first?.distance, let travelTimeUnwrapped = response.routes.first?.expectedTravelTime else {
                    print("Error: -- RouteController -- calculateRoute -- Distance/TravelTime")
                    return
                }
                
                distance = distanceUnwrapped
                travelTime = travelTimeUnwrapped
                completion(distance, travelTime)
            }
        }
    }
    
    
    private func getCorrectValue(distance: CLLocationDistance) -> String {
        return distance < 1000 ? "\(distance) m" : "\(distance / 1000) km"
    }
    
    private func getCorrectValue(travelTime: TimeInterval) -> String {
        var time : Double = 0
        //return time < 60 ? "\(time) s" : time < 3600 ? "\(time / 60 ) min" : "\(time / 60 / 60) h"
        
        if travelTime < 60 {
            time = travelTime
            return "\(Int(round(time))) s"
        }
        else if travelTime < 3600 {
            time = (travelTime / 60)
            return "\(Int(round(time))) min"
        }
        else {
            time = (travelTime / 60 / 60)
            return "\(Double(round(time * 10) / 10)) h"
        }
    }
}
