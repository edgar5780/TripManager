//
//  TripAnnotation.swift
//  TripManager
//
//  Created by Edgar Luis Diaz on 07/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import MapKit

final class TripAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D

    init(_ address: String?, _ coordinates: CLLocationCoordinate2D) {
        self.title = address
        self.coordinate = coordinates
    }
}
