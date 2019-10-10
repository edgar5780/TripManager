//
//  GetTripsAvailableUseCaseTest.swift
//  TripManagerDomainTests
//
//  Created by Edgar Luis Diaz on 06/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import XCTest
import Combine
@testable import TripManagerDomain

final class GetTripsAvailableUseCaseTest: XCTestCase {
    var useCase: GetTripsAvailableUseCase?
    var disposables: Set<AnyCancellable>?

    override func setUp() {
        disposables = Set<AnyCancellable>()
    }

    override func tearDown() {
        useCase = nil
        disposables = nil
    }

    func testRepositoryGetTripsSuccess() {
        let repository = TripsRepositorySuccessMockup()
        useCase = GetTripsAvailableUseCaseImp(repository)
        let expectation = XCTestExpectation(description: "invoke() finished")
        useCase?.invoke().sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                expectation.fulfill()
            case .failure(let error):
                XCTFail("invoke() shouldn't fail. Error: \(error)")
                expectation.fulfill()
            }
        }, receiveValue: { trips in
            XCTAssertEqual(trips.count, 1)
        }).store(in: &disposables!)
        wait(for: [expectation], timeout: 5.0)
    }

    func testRepositoryGetTripsFails() {
        let repository = TripsRepositoryFailureMockup()
        useCase = GetTripsAvailableUseCaseImp(repository)
        let expectation = XCTestExpectation(description: "invoke() fails")
        useCase?.invoke().sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                XCTFail("invoke() should fail.")
                expectation.fulfill()
            case .failure(let error):
                switch error {
                case .api(let description):
                    XCTAssertEqual(description, "Test error")
                default:
                    XCTFail("The error should be api error")
                }
                expectation.fulfill()
            }
        }, receiveValue: { _ in
            XCTFail("invoke() should fail.")
        }).store(in: &disposables!)
        wait(for: [expectation], timeout: 5.0)
    }
}
