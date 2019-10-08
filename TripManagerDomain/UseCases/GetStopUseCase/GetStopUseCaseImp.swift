//
//  GetStopUseCaseImp.swift
//  TripManagerDomain
//
//  Created by Edgar Luis Diaz on 08/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine

final class GetStopUseCaseImp: GetStopUseCase {
    private let repository: StopsRepository

    init(_ repository: StopsRepository) {
        self.repository = repository
    }

    func invoke(_ id: Int) -> AnyPublisher<StopDetails, TripManagerError> {
        repository.getStop(id)
    }
}
