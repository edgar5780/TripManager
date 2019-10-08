//
//  StopsRepository.swift
//  TripManagerDomain
//
//  Created by Edgar Luis Diaz on 08/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine

public protocol StopsRepository {
    func getStop(_ id: Int) -> AnyPublisher<StopDetails, TripManagerError>
}
