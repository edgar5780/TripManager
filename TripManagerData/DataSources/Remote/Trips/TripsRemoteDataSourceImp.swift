//
//  TripsRemoteDataSourceImp.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 05/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine
import TripManagerDomain

final class TripsRemoteDataSourceImp: BaseRemoteDataSource, TripsRemoteDataSource {
    func getTrips() -> AnyPublisher<[Trip], TripManagerError> {
        requestGetTrips().map { $0.map { $0.toDomain() } }.eraseToAnyPublisher()
    }

    private func requestGetTrips() -> AnyPublisher<[TripResponse], TripManagerError> {
        apiCall(.trips, .get, nil, nil)
    }
}
