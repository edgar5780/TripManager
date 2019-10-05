//
//  TripsRepositoryTest.swift
//  TripManagerDataTests
//
//  Created by Edgar Luis Diaz on 06/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import XCTest
import Combine
import TripManagerDomain
@testable import TripManagerData

class TripsRepositoryTest: XCTestCase {
    var repository: TripsRepository?
    var disposables: Set<AnyCancellable>?

    override func setUp() {
        disposables = Set<AnyCancellable>()
    }

    override func tearDown() {
        repository = nil
        disposables = nil
    }

    func testRepositoryGetTripsSuccess() {
        let remoteDataSource = TripsRemoteDataSourceSuccessMockup()
        repository = TripsRepositoryImp(remoteDataSource)
        let expectation = XCTestExpectation(description: "getTrips() finished")
        repository?.getTrips().sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                expectation.fulfill()
            case .failure(let error):
                XCTFail("getTrips() shouldn't fail. Error: \(error)")
                expectation.fulfill()
            }
        }, receiveValue: { trips in
            XCTAssertEqual(trips.count, 1)
        }).store(in: &disposables!)
    }

    func testRepositoryGetTripsFails() {
        let remoteDataSource = TripsRemoteDataSourceFailureMockup()
        repository = TripsRepositoryImp(remoteDataSource)
        let expectation = XCTestExpectation(description: "getTrips() fails")
        repository?.getTrips().sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                XCTFail("getTrips() should fail.")
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
            XCTFail("getTrips() should fail.")
        }).store(in: &disposables!)
    }

}
