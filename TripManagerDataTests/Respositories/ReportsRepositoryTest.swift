//
//  ReportsRepositoryTest.swift
//  TripManagerDataTests
//
//  Created by Edgar Luis Diaz on 11/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import XCTest
import Combine
import TripManagerDomain
@testable import TripManagerData

final class ReportsRepositoryTest: XCTestCase {
    var repository: ReportsRepository?
    var disposables: Set<AnyCancellable>?

    override func setUp() {
        disposables = Set<AnyCancellable>()
    }

    override func tearDown() {
        repository = nil
        disposables = nil
    }

    func testRepositoryGetStopSuccessRemote() {
        let localDataSource = ReportsLocalDataSourceSuccessMockup()
        repository = ReportsRepositoryImp(localDataSource)
        let expectation = XCTestExpectation(description: "getReports() finished")
        repository?.getReports().sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                expectation.fulfill()
            case .failure(let error):
                XCTFail("getReports() shouldn't fail. Error: \(error)")
                expectation.fulfill()
            }
        }, receiveValue: { reports in
            XCTAssertEqual(reports.count, 2)
        }).store(in: &disposables!)
        wait(for: [expectation], timeout: 5.0)
    }

    func testRepositoryGetTripsFailsRemote() {
        let localDataSource = ReportsLocalDataSourceFailureMockup()
        repository = ReportsRepositoryImp(localDataSource)
        let expectation = XCTestExpectation(description: "getReports() finished")
        repository?.getReports().sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                XCTFail("getReports() should fail.")
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
            XCTFail("getReports() should fail.")
        }).store(in: &disposables!)
        wait(for: [expectation], timeout: 5.0)
    }
}
