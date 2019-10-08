//
//  GetTripsAvailableUseCaseImp.swift
//  TripManagerDomain
//
//  Created by Edgar Luis Diaz on 06/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine

final class GetTripsAvailableUseCaseImp: GetTripsAvailableUseCase {
    private let repository: TripsRepository

    init(_ repository: TripsRepository) {
        self.repository = repository
    }

    func invoke() -> AnyPublisher<[Trip], TripManagerError> {
        repository.getTrips().map { trips in
            trips.filter { $0.status == .scheduled || $0.status == .ongoing }
        }.eraseToAnyPublisher()
    }
}
