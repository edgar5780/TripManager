//
//  ContactFormViewModelTest.swift
//  TripManagerTests
//
//  Created by Edgar Luis Diaz on 11/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import XCTest
import UIKit
import Combine
@testable import TripManagerDomain
@testable import TripManager

final class ContactFormViewModelTest: XCTestCase {
    var viewModel: ContactFormViewModel?
    var disposables: Set<AnyCancellable>?

    override func setUp() {
        let saveReportUseCase = SaveReportUseCaseMockup()
        let getReportsNumberUseCase = GetReportsNumberUseCaseMockup()
        viewModel = ContactFormViewModel(saveReportUseCase, getReportsNumberUseCase)
        disposables = Set<AnyCancellable>()
    }

    override func tearDown() {
        viewModel = nil
        disposables = nil
    }

    func testFormValidation() {
        let expectation = XCTestExpectation(description: "Form valid")
        viewModel?.$saveDisabled.sink(receiveValue: { disabled in
            if !disabled {
                expectation.fulfill()
            }
        }).store(in: &disposables!)
        viewModel?.name = "Test"
        viewModel?.surname = "Test"
        viewModel?.email = "Test"
        viewModel?.details = "Test"
        wait(for: [expectation], timeout: 5.0)
    }
}
