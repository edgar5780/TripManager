//
//  ReportsLocalDataSource.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 11/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine
import TripManagerDomain

protocol ReportsLocalDataSource {
    func saveReport(_ report: Report)
    func getReports() -> AnyPublisher<[Report], TripManagerError>
}
