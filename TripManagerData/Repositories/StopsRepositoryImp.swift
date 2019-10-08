//
//  StopsRepositoryImp.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 08/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine
import TripManagerDomain

final class StopsRepositoryImp: StopsRepository {
    private let remoteDataSource: StopsRemoteDataSource

    init(_ remoteDataSource: StopsRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getStop(_ id: Int) -> AnyPublisher<StopDetails, TripManagerError> {
        remoteDataSource.getStop(id)
    }
}
