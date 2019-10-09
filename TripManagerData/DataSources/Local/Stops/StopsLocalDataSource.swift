//
//  StopsLocalDataSource.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 09/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine
import TripManagerDomain

protocol StopsLocalDataSource {
    func saveInCache(_ id: Int, _ stop: StopDetails)
    func getStopDetails(_ id: Int) -> AnyPublisher<StopDetails, TripManagerError>
}
