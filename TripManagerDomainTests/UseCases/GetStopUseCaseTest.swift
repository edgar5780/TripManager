//
//  GetStopUseCaseTest.swift
//  TripManagerDomainTests
//
//  Created by Edgar Luis Diaz on 08/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import XCTest
import Combine
@testable import TripManagerDomain

class GetStopUseCaseTest: XCTestCase {
    var useCase: GetStopUseCase?
    var disposables: Set<AnyCancellable>?

    override func setUp() {
        disposables = Set<AnyCancellable>()
    }

    override func tearDown() {
        useCase = nil
        disposables = nil
    }

    func testRepositoryGetTripsSuccess() {
        let repository = StopsRepositorySuccessMockup()
        useCase = GetStopUseCaseImp(repository)
        let expectation = XCTestExpectation(description: "invoke() finished")
        useCase?.invoke(0).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                expectation.fulfill()
            case .failure(let error):
                XCTFail("invoke() shouldn't fail. Error: \(error)")
                expectation.fulfill()
            }
        }, receiveValue: { stop in
            XCTAssertEqual(stop.stopTime, Date(timeIntervalSince1970: 1570558839))
            XCTAssertEqual(stop.paid, true)
            XCTAssertEqual(stop.address, "Ramblas, Barcelona")
            XCTAssertEqual(stop.userName, "Manuel Gomez")
            XCTAssertEqual(stop.point.latitude, 41.37653)
            XCTAssertEqual(stop.point.longitude, 2.17924)
            XCTAssertEqual(stop.price, 1.5)
        }).store(in: &disposables!)
        wait(for: [expectation], timeout: 5.0)
    }

    func testRepositoryGetTripsFails() {
        let repository = StopsRepositoryFailureMockup()
        useCase = GetStopUseCaseImp(repository)
        let expectation = XCTestExpectation(description: "invoke() fails")
        useCase?.invoke(0).sink(receiveCompletion: { completion in
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
