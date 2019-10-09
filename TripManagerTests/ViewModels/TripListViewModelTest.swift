//
//  TripListViewModelTest.swift
//  TripManagerTests
//
//  Created by Edgar Luis Diaz on 08/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import XCTest
import Combine
@testable import TripManagerDomain
@testable import TripManager

class TripListViewModelTest: XCTestCase {
    var viewModel: TripListViewModel?
    var disposables: Set<AnyCancellable>?

    override func setUp() {
        let getTripsAvailableUseCase = GetTripsAvailableUseCaseMockup()
        let getStopUseCase = GetStopUseCaseMockup()
        viewModel = TripListViewModel(getTripsAvailableUseCase,
                                      getStopUseCase)
        disposables = Set<AnyCancellable>()
    }

    override func tearDown() {
        viewModel = nil
        disposables = nil
    }

    func testDataSourceFetch() {
        let expectation = XCTestExpectation(description: "DataSource fetch")
        var count = 0
        viewModel?.$dataSource.sink { uiModels in
            if count == 0 {
                XCTAssertEqual(uiModels.count, 0)
            } else if count == 1 {
                XCTAssertEqual(uiModels.count, 2)
                expectation.fulfill()
            }
            count += 1
        }.store(in: &disposables!)
        viewModel?.fetch()
        wait(for: [expectation], timeout: 5.0)
    }

    func testStopDetailsFetch() {
        let expectation = XCTestExpectation(description: "Stop details fetch")
        var count = 0
        viewModel?.$stopDetails.sink { stop in
            if count == 0 {
                XCTAssertNil(stop)
            } else if count == 1 {
                XCTAssertEqual(stop?.stopTime, Date(timeIntervalSince1970: 1570558839))
                XCTAssertEqual(stop?.paid, true)
                XCTAssertEqual(stop?.address, "Ramblas, Barcelona")
                XCTAssertEqual(stop?.userName, "Manuel Gomez")
                XCTAssertEqual(stop?.point.latitude, 41.37653)
                XCTAssertEqual(stop?.point.longitude, 2.17924)
                XCTAssertEqual(stop?.price, 1.5)
                expectation.fulfill()
            }
            count += 1
        }.store(in: &disposables!)
        viewModel?.annotationSelected(0)
        wait(for: [expectation], timeout: 5.0)
    }
}
