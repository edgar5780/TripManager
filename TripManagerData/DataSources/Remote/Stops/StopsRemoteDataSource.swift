//
//  StopsRemoteDataSource.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 08/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine
import TripManagerDomain

protocol StopsRemoteDataSource {
    func getStop(_ id: Int) -> AnyPublisher<StopDetails, TripManagerError>
}
