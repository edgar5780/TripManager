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
    private let localDataSource: StopsLocalDataSource

    init(_ remoteDataSource: StopsRemoteDataSource,
         _ localDataSource: StopsLocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }

    func getStop(_ id: Int) -> AnyPublisher<StopDetails, TripManagerError> {
        localDataSource.getStopDetails(id).catch { [weak self] _ -> AnyPublisher<StopDetails, TripManagerError> in
            guard let self = self else {
                return Fail(error: TripManagerError.generic).eraseToAnyPublisher()
            }
            return self.getRemoteStop(id)
        }.eraseToAnyPublisher()
    }

    private func getRemoteStop(_ id: Int) -> AnyPublisher<StopDetails, TripManagerError> {
        remoteDataSource.getStop(id).handleEvents(receiveOutput: { [weak self] stop in
            guard let self = self else { return }
            self.localDataSource.saveInCache(id, stop)
        }).eraseToAnyPublisher()
    }
}
