//
//  ReportsLocalDataSourceMockup.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 11/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine
import TripManagerDomain

final class ReportsLocalDataSourceSuccessMockup: ReportsLocalDataSource {
    func saveReport(_ report: Report) {}

    func getReports() -> AnyPublisher<[Report], TripManagerError> {
        let reports = [Report(name: "",
                              surname: "",
                              email: "",
                              phone: "",
                              details: "",
                              date: Date()),
                       Report(name: "",
                              surname: "",
                              email: "",
                              phone: "",
                              details: "",
                              date: Date())]
        return Just(reports).setFailureType(to: TripManagerError.self).eraseToAnyPublisher()
    }
}

final class ReportsLocalDataSourceFailureMockup: ReportsLocalDataSource {
    func saveReport(_ report: Report) {}

    func getReports() -> AnyPublisher<[Report], TripManagerError> {
        Fail(error: TripManagerError.database).eraseToAnyPublisher()
    }
}
