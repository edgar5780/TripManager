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
        let useCase = GetTripsAvailableUseCaseMockup()
        viewModel = TripListViewModel(useCase)
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
}
