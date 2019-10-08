//
//  GetTripsAvailableUseCaseMockup.swift
//  TripManagerDomain
//
//  Created by Edgar Luis Diaz on 08/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine

final class GetTripsAvailableUseCaseMockup: GetTripsAvailableUseCase {
    func invoke() -> AnyPublisher<[Trip], TripManagerError> {
        let trips: [Trip] = [Trip(driverName: "Driver",
                                  description: "Description",
                                  status: .ongoing,
                                  startTime: Date(timeIntervalSince1970: 1570315624),
                                  endTime: Date(timeIntervalSince1970: 1570313624),
                                  route: "sdq{Fc}iLeoBrgBs@xsGecD|sEswEv|Cek@cyA",
                                  origin: Location(address: "Origin Address",
                                                   point: Point(latitude: 0, longitude: 0)),
                                  destination: Location(address: "Destination Address",
                                                        point: Point(latitude: 0, longitude: 0)),
                                  stops: [Stop(id: 1,
                                               point: Point(latitude: 0, longitude: 0))]),
                             Trip(driverName: "Driver",
                                  description: "Description",
                                  status: .finalized,
                                  startTime: Date(timeIntervalSince1970: 1570315624),
                                  endTime: Date(timeIntervalSince1970: 1570313624),
                                  route: "sdq{Fc}iLeoBrgBs@xsGecD|sEswEv|Cek@cyA",
                                  origin: Location(address: "Origin Address",
                                                   point: Point(latitude: 0, longitude: 0)),
                                  destination: Location(address: "Destination Address",
                                                        point: Point(latitude: 0, longitude: 0)),
                                  stops: [Stop(id: 1,
                                               point: Point(latitude: 0, longitude: 0))])]
        return Just(trips).setFailureType(to: TripManagerError.self).eraseToAnyPublisher()
    }
}
