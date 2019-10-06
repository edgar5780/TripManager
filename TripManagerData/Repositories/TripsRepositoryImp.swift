//
//  TripsRepositoryImp.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 05/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine
import TripManagerDomain

final class TripsRepositoryImp: TripsRepository {
    let remoteDataSource: TripsRemoteDataSource

    init(_ remoteDataSource: TripsRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getTrips() -> AnyPublisher<[Trip], TripManagerError> {
        remoteDataSource.getTrips()
    }
}
