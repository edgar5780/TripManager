//
//  TripResponse.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 05/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import TripManagerDomain

struct TripResponse: BaseResponseModel {
    var driverName: String
    var description: String
    var status: String
    var startTime: Date
    var endTime: Date
    var route: String
    var origin: LocationResponse
    var destination: LocationResponse
    var stops: [StopResponse]

    func toDomain() -> Trip {
        let status = TripStatus(rawValue: self.status) ?? .unknown
        let stops = self.stops.compactMap { $0.toDomain() }
        return Trip(driverName: driverName,
                    description: description,
                    status: status,
                    startTime: startTime,
                    endTime: endTime,
                    route: route,
                    origin: origin.toDomain(),
                    destination: destination.toDomain(),
                    stops: stops)
    }
}
