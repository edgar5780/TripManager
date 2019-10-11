//
//  ContactFormViewModel.swift
//  TripManager
//
//  Created by Edgar Luis Diaz on 10/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine
import TripManagerDomain

final class ContactFormViewModel: ObservableObject {
    private let saveReportUseCase: SaveReportUseCase
    private let getReportsNumberUseCase: GetReportsNumberUseCase
    private var disposables = Set<AnyCancellable>()
    let objectWillChange = PassthroughSubject<ContactFormViewModel, Never>()
    @Published var saveDisabled: Bool
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

    init(_ saveReportUseCase: SaveReportUseCase,
         _ getReportsNumberUseCase: GetReportsNumberUseCase) {
        self.saveReportUseCase = saveReportUseCase
        self.getReportsNumberUseCase = getReportsNumberUseCase
        saveDisabled = true
        name = ""
        surname = ""
        email = ""
        phone = ""
        details = ""
        date = Date()
    }

    func save() {
        let report = Report(name: name,
                            surname: surname,
                            email: email,
                            phone: phone,
                            details: details,
                            date: date)
        saveReportUseCase.invoke(report)
        updateBadge()
    }

    private func updateBadge() {
        getReportsNumberUseCase.invoke().sink(receiveCompletion: { _ in }, receiveValue: { number in
            BadgeUtils().updateBadge(number)
        }).store(in: &disposables)
    }

    private func validateForm() {
        saveDisabled = name.isEmpty || surname.isEmpty || email.isEmpty || details.isEmpty
        objectWillChange.send(self)
    }
}
