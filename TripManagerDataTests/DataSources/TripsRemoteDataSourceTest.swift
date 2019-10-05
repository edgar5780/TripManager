//
//  TripsRemoteDataSourceTest.swift
//  TripManagerDataTests
//
//  Created by Edgar Luis Diaz on 05/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import XCTest
import Combine
import TripManagerDomain
@testable import TripManagerData

class TripsRemoteDataSourceTest: XCTestCase {
    var tripsRemoteDataSource: TripsRemoteDataSource?
    var disposables: Set<AnyCancellable>?

    override func setUp() {
        let apiMocked = TripsAPIClientMockup()
        tripsRemoteDataSource = TripsRemoteDataSourceImp(apiMocked)
        disposables = Set<AnyCancellable>()
    }

    override func tearDown() {
        tripsRemoteDataSource = nil
        disposables = nil
    }

    func testGetTrips() {
        let expectation = XCTestExpectation(description: "getTrips() finished")
        tripsRemoteDataSource?.getTrips().sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                expectation.fulfill()
            case .failure(let error):
                XCTFail("getTrips() shouldn't fail. Error: \(error)")
                expectation.fulfill()
            }
        }, receiveValue: { trips in
            XCTAssertEqual(trips.count, 7)
        }).store(in: &disposables!)
        wait(for: [expectation], timeout: 5.0)
    }
}
