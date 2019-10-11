//
//  ReportsRepositoryImp.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 11/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine
import TripManagerDomain

final class ReportsRepositoryImp: ReportsRepository {
    private let localDataSource: ReportsLocalDataSource

    init(_ localDataSource: ReportsLocalDataSource) {
        self.localDataSource = localDataSource
    }

    func saveReport(_ report: Report) {
        localDataSource.saveReport(report)
    }

    func getReports() -> AnyPublisher<[Report], TripManagerError> {
        localDataSource.getReports()
    }
}
