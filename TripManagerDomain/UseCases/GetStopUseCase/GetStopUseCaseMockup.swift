//
//  GetStopUseCaseMockup.swift
//  TripManagerDomain
//
//  Created by Edgar Luis Diaz on 08/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine

final class GetStopUseCaseMockup: GetStopUseCase {
    func invoke(_ id: Int) -> AnyPublisher<StopDetails, TripManagerError> {
        let stopDetails = StopDetails(stopTime: Date(timeIntervalSince1970: 1570558839),
                                      paid: true,
                                      address: "Ramblas, Barcelona",
                                      userName: "Manuel Gomez",
                                      point: Point(latitude: 41.37653, longitude: 2.17924),
                                      price: 1.5)
        return Just(stopDetails).setFailureType(to: TripManagerError.self).eraseToAnyPublisher()
    }
}
