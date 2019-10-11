//
//  SaveReportUseCaseImp.swift
//  TripManagerDomain
//
//  Created by Edgar Luis Diaz on 11/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation

final class SaveReportUseCaseImp: SaveReportUseCase {
    private let repository: ReportsRepository

    init(_ repository: ReportsRepository) {
        self.repository = repository
    }

    func invoke(_ report: Report) {
        repository.saveReport(report)
    }
}
