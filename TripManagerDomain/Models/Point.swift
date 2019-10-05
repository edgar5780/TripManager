//
//  Point.swift
//  TripManagerDomain
//
//  Created by Edgar Luis Diaz on 05/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation

public struct Point {
    public var latitude: Double
    public var longitude: Double

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
