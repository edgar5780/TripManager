//
//  ReportsLocalDataSourceImp.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 11/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine
import RealmSwift
import TripManagerDomain

final class ReportsLocalDataSourceImp: ReportsLocalDataSource {
    func saveReport(_ report: Report) {
        ReportRealmModel(report).save(false)
    }

    func getReports() -> AnyPublisher<[Report], TripManagerError> {
        do {
            let realm = try Realm()
            let reportsRealmModel = realm.objects(ReportRealmModel.self)
            let reports: [Report] = reportsRealmModel.map { $0.toDomain() }
            return Just(reports).setFailureType(to: TripManagerError.self).eraseToAnyPublisher()
        } catch {
            return Fail(error: TripManagerError.database).eraseToAnyPublisher()
        }
    }
}
