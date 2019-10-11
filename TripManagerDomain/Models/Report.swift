//
//  Report.swift
//  TripManagerDomain
//
//  Created by Edgar Luis Diaz on 11/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation

public struct Report {
    public var name: String
    public var surname: String
    public var email: String
    public var phone: String
    public var details: String
    public var date: Date

    public init(name: String,
                surname: String,
                email: String,
                phone: String,
                details: String,
                date: Date) {
        self.name = name
        self.surname = surname
        self.email = email
        self.phone = phone
        self.details = details
        self.date = date
    }
}
