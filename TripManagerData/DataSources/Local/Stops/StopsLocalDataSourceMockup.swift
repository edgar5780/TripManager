//
//  StopsLocalDataSourceMockup.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 10/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine
import TripManagerDomain

final class StopsLocalDataSourceSuccessMockup: StopsLocalDataSource {
    func saveInCache(_ id: Int, _ stop: StopDetails) {}

    func getStopDetails(_ id: Int) -> AnyPublisher<StopDetails, TripManagerError> {
        let stopDetails = StopDetails(stopTime: Date(timeIntervalSince1970: 1570558839),
                                      paid: true,
                                      address: "Ramblas, Barcelona",
                                      userName: "Manuel Diaz",
                                      point: Point(latitude: 41.37653, longitude: 2.17924),
                                      price: 1.5)
        return Just(stopDetails).setFailureType(to: TripManagerError.self).eraseToAnyPublisher()
    }
}

final class StopsLocalDataSourceFailureMockup: StopsLocalDataSource {
    func saveInCache(_ id: Int, _ stop: StopDetails) {}

    func getStopDetails(_ id: Int) -> AnyPublisher<StopDetails, TripManagerError> {
        return Fail(error: TripManagerError.elementNotFound).eraseToAnyPublisher()
    }
}
