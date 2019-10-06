//
//  GetTripsUseCase.swift
//  TripManagerDomain
//
//  Created by Edgar Luis Diaz on 06/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine

public protocol GetTripsUseCase {
    func invoke() -> AnyPublisher<[Trip], TripManagerError>
}
