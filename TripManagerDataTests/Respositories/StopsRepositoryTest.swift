//
//  StopsRepositoryTest.swift
//  TripManagerDataTests
//
//  Created by Edgar Luis Diaz on 08/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import XCTest
import Combine
import TripManagerDomain
@testable import TripManagerData

final class StopsRepositoryTest: XCTestCase {
    var repository: StopsRepository?
    var disposables: Set<AnyCancellable>?

    override func setUp() {
        disposables = Set<AnyCancellable>()
    }

    override func tearDown() {
        repository = nil
        disposables = nil
    }

    func testRepositoryGetStopSuccessRemote() {
        let remoteDataSource = StopsRemoteDataSourceSuccessMockup()
        let localDataSource = StopsLocalDataSourceFailureMockup()
        repository = StopsRepositoryImp(remoteDataSource, localDataSource)
        let expectation = XCTestExpectation(description: "getStop() finished")
        repository?.getStop(0).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                expectation.fulfill()
            case .failure(let error):
                XCTFail("getStop() shouldn't fail. Error: \(error)")
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

    func testRepositoryGetTripsFailsRemote() {
        let remoteDataSource = StopsRemoteDataSourceFailureMockup()
        let localDataSource = StopsLocalDataSourceFailureMockup()
        repository = StopsRepositoryImp(remoteDataSource, localDataSource)
        let expectation = XCTestExpectation(description: "getStop() fails")
        repository?.getStop(0).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                XCTFail("getStop() should fail.")
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
            XCTFail("getStop() should fail.")
        }).store(in: &disposables!)
        wait(for: [expectation], timeout: 5.0)
    }

    func testRepositoryGetStopSuccessLocal() {
        let remoteDataSource = StopsRemoteDataSourceSuccessMockup()
        let localDataSource = StopsLocalDataSourceSuccessMockup()
        repository = StopsRepositoryImp(remoteDataSource, localDataSource)
        let expectation = XCTestExpectation(description: "getStop() finished")
        repository?.getStop(0).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                expectation.fulfill()
            case .failure(let error):
                XCTFail("getStop() shouldn't fail. Error: \(error)")
                expectation.fulfill()
            }
        }, receiveValue: { stop in
            XCTAssertEqual(stop.stopTime, Date(timeIntervalSince1970: 1570558839))
            XCTAssertEqual(stop.paid, true)
            XCTAssertEqual(stop.address, "Ramblas, Barcelona")
            XCTAssertEqual(stop.userName, "Manuel Diaz")
            XCTAssertEqual(stop.point.latitude, 41.37653)
            XCTAssertEqual(stop.point.longitude, 2.17924)
            XCTAssertEqual(stop.price, 1.5)
        }).store(in: &disposables!)
        wait(for: [expectation], timeout: 5.0)
    }

    func testRepositoryGetTripsFailsLocal() {
        let remoteDataSource = StopsRemoteDataSourceFailureMockup()
        let localDataSource = StopsLocalDataSourceSuccessMockup()
        repository = StopsRepositoryImp(remoteDataSource, localDataSource)
        let expectation = XCTestExpectation(description: "getStop() fails")
        repository?.getStop(0).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                expectation.fulfill()
            case .failure(let error):
                XCTFail("getStop() shouldn't fail. Error: \(error)")
                expectation.fulfill()
            }
        }, receiveValue: { stop in
            XCTAssertEqual(stop.stopTime, Date(timeIntervalSince1970: 1570558839))
            XCTAssertEqual(stop.paid, true)
            XCTAssertEqual(stop.address, "Ramblas, Barcelona")
            XCTAssertEqual(stop.userName, "Manuel Diaz")
            XCTAssertEqual(stop.point.latitude, 41.37653)
            XCTAssertEqual(stop.point.longitude, 2.17924)
            XCTAssertEqual(stop.price, 1.5)
        }).store(in: &disposables!)
        wait(for: [expectation], timeout: 5.0)
    }
}
