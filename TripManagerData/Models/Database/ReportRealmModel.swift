//
//  ReportRealmModel.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 11/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import RealmSwift
import TripManagerDomain

final class ReportRealmModel: Object, BaseDataModel {
    @objc dynamic var name: String = ""
    @objc dynamic var surname: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var details: String = ""
    @objc dynamic var date: Date = Date()

    convenience init(_ report: Report) {
        self.init()
        name = report.name
        surname = report.surname
        email = report.email
        phone = report.phone
        details = report.details
        date = report.date
    }

    func toDomain() -> Report {
        Report(name: name,
               surname: surname,
               email: email,
               phone: phone,
               details: details,
               date: date)
    }
}
