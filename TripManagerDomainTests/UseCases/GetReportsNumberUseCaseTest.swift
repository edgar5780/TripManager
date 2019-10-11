//
//  GetReportsNumberUseCaseTest.swift
//  TripManagerDomainTests
//
//  Created by Edgar Luis Diaz on 11/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import XCTest
import Combine
@testable import TripManagerDomain

final class GetReportsNumberUseCaseTest: XCTestCase {
    var useCase: GetReportsNumberUseCase?
    var disposables: Set<AnyCancellable>?

    override func setUp() {
        disposables = Set<AnyCancellable>()
    }

    override func tearDown() {
        useCase = nil
        disposables = nil
    }

    func testRepositoryGetTripsSuccess() {
        let repository = ReportsRepositorySuccessMockup()
        useCase = GetReportsNumberUseCaseImp(repository)
        let expectation = XCTestExpectation(description: "invoke() finished")
        useCase?.invoke().sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                expectation.fulfill()
            case .failure(let error):
                XCTFail("invoke() shouldn't fail. Error: \(error)")
                expectation.fulfill()
            }
        }, receiveValue: { number in
            XCTAssertEqual(number, 2)
        }).store(in: &disposables!)
        wait(for: [expectation], timeout: 5.0)
    }

    func testRepositoryGetTripsFails() {
        let repository = ReportsRepositoryFailureMockup()
        useCase = GetReportsNumberUseCaseImp(repository)
        let expectation = XCTestExpectation(description: "invoke() fails")
        useCase?.invoke().sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                XCTFail("invoke() should fail.")
                expectation.fulfill()
            case .failure(let error):
                switch error {
                case .database:
                    expectation.fulfill()
                default:
                    XCTFail("The error should be database error")
                }
            }
        }, receiveValue: { _ in
            XCTFail("invoke() should fail.")
        }).store(in: &disposables!)
        wait(for: [expectation], timeout: 5.0)
    }
}
