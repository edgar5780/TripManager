//
//  Trip.swift
//  TripManagerDomain
//
//  Created by Edgar Luis Diaz on 05/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation

public struct Trip {
    public var driverName: String
    public var description: String
    public var status: TripStatus
    public var startTime: Date
    public var endTime: Date
    public var route: String
    public var origin: Location
    public var destination: Location
    public var stops: [Stop]

    public init(driverName: String,
                description: String,
                status: TripStatus,
                startTime: Date,
                endTime: Date,
                route: String,
                origin: Location,
                destination: Location,
                stops: [Stop]) {
        self.driverName = driverName
        self.description = description
        self.status = status
        self.startTime = startTime
        self.endTime = endTime
        self.route = route
        self.origin = origin
        self.destination = destination
        self.stops = stops
    }
}
