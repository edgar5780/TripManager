//
//  TripsRemoteDataSource.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 05/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine
import TripManagerDomain

protocol TripsRemoteDataSource {
    func getTrips() -> AnyPublisher<[Trip], TripManagerError>
}
