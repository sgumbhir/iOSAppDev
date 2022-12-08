//
//  Marker.swift
//  DoorDrink
//
//  Created by Samiksha Gumbhir on 12/3/22.
//

import Foundation
import MapKit
import CoreLocation

// Marker object that defines the pins
class Marker: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    public var image: UIImage?
    
    init(coordinate: CLLocationCoordinate2D,
         title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
