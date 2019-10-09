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
    let id: Int?

    init(_ address: String?, _ coordinate: CLLocationCoordinate2D, _ id: Int?) {
        self.title = address
        self.coordinate = coordinate
        self.id = id
    }
}
