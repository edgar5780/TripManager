//
//  ReportsRepository.swift
//  TripManagerDomain
//
//  Created by Edgar Luis Diaz on 11/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine

public protocol ReportsRepository {
    func saveReport(_ report: Report)
    func getReports() -> AnyPublisher<[Report], TripManagerError>
}
