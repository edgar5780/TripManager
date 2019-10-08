//
//  StopsRemoteDataSourceImp.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 08/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine
import TripManagerDomain

final class StopsRemoteDataSourceImp: BaseRemoteDataSource, StopsRemoteDataSource {
    func getStop(_ id: Int) -> AnyPublisher<StopDetails, TripManagerError> {
        requestGetStop(id).map { $0.toDomain() }.eraseToAnyPublisher()
    }

    private func requestGetStop(_ id: Int) -> AnyPublisher<StopDetailsResponse, TripManagerError> {
        apiCall(.stop(id: id), .get, nil, nil)
    }
}
