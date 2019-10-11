//
//  GetReportsNumberUseCaseMockup.swift
//  TripManagerDomain
//
//  Created by Edgar Luis Diaz on 11/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine

final class GetReportsNumberUseCaseMockup: GetReportsNumberUseCase {
    func invoke() -> AnyPublisher<Int, TripManagerError> {
        Just(3).setFailureType(to: TripManagerError.self).eraseToAnyPublisher()
    }
}
