//
//  Strings.swift
//  TripManager
//
//  Created by Edgar Luis Diaz on 07/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation

enum Strings: String {
    case driverName = "DriverName"
    case noResults = "NoResults"
    case paid = "Paid"
    case notPaid = "NotPaid"
    case contactForm = "ContactForm"
    case save = "Save"
    case cancel = "Cancel"
    case name = "Name"
    case surname = "Surname"
    case email = "Email"
    case phone = "Phone"
    case date = "Date"
    case details = "Details"

    func localize(_ args: CVarArg...) -> String {
        let localizedString = NSLocalizedString(self.rawValue, comment: "")
        return String(format: localizedString, arguments: args)
    }
}
