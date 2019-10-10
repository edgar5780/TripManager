//
//  ContactFormViewModel.swift
//  TripManager
//
//  Created by Edgar Luis Diaz on 10/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine

final class ContactFormViewModel: ObservableObject {
    let objectWillChange = PassthroughSubject<ContactFormViewModel, Never>()
    var saveDisabled: Bool
    var name: String {
        didSet {
            validateForm()
        }
    }
    var surname: String {
           didSet {
               validateForm()
           }
       }
    var email: String {
           didSet {
               validateForm()
           }
       }
    var phone: String
    var details: String {
           didSet {
               validateForm()
           }
       }
    var date: Date {
        willSet {
            self.date = newValue
            objectWillChange.send(self)
        }
    }

    init() {
        saveDisabled = true
        name = ""
        surname = ""
        email = ""
        phone = ""
        details = ""
        date = Date()
    }

    private func validateForm() {
        saveDisabled = name.isEmpty || surname.isEmpty || email.isEmpty || details.isEmpty
        objectWillChange.send(self)
    }
}
