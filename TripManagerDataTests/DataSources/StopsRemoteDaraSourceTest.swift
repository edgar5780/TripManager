//
//  StopsRemoteDaraSourceTest.swift
//  TripManagerDataTests
//
//  Created by Edgar Luis Diaz on 08/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import XCTest
import Combine
import TripManagerDomain
@testable import TripManagerData

final class StopsRemoteDataSourceTest: XCTestCase {
    var stopsRemoteDataSource: StopsRemoteDataSource?
    var disposables: Set<AnyCancellable>?

    override func setUp() {
        let apiMocked = StopsAPIClientMockup()
        stopsRemoteDataSource = StopsRemoteDataSourceImp(apiMocked)
        disposables = Set<AnyCancellable>()
    }

    override func tearDown() {
        stopsRemoteDataSource = nil
        disposables = nil
    }

    func testGetStop() {
        let expectation = XCTestExpectation(description: "getStop() finished")
        stopsRemoteDataSource?.getStop(0).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                expectation.fulfill()
            case .failure(let error):
                XCTFail("getStop() shouldn't fail. Error: \(error)")
                expectation.fulfill()
            }
        }, receiveValue: { stop in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            XCTAssertEqual(stop.stopTime, dateFormatter.date(from: "2018-12-18T08:10:00.000Z"))
            XCTAssertEqual(stop.paid, true)
            XCTAssertEqual(stop.address, "Ramblas, Barcelona")
            XCTAssertEqual(stop.userName, "Manuel Gomez")
            XCTAssertEqual(stop.point.latitude, 41.37653)
            XCTAssertEqual(stop.point.longitude, 2.17924)
            XCTAssertEqual(stop.price, 1.5)
        }).store(in: &disposables!)
        wait(for: [expectation], timeout: 5.0)
    }
}
