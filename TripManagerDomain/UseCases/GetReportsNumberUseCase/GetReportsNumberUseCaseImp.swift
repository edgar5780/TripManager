//
//  GetReportsNumberUseCaseImp.swift
//  TripManagerDomain
//
//  Created by Edgar Luis Diaz on 11/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine

final class GetReportsNumberUseCaseImp: GetReportsNumberUseCase {
    private let repository: ReportsRepository

    init(_ repository: ReportsRepository) {
        self.repository = repository
    }

    func invoke() -> AnyPublisher<Int, TripManagerError> {
        repository.getReports().map { $0.count }.eraseToAnyPublisher()
    }
}
