//
//  URLFactoryTests.swift
//  TripManagerDataTests
//
//  Created by Edgar Luis Diaz on 05/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import XCTest
@testable import TripManagerData

class URLFactoryTests: XCTestCase {
    let urlFactory = URLFactory()

    func testGenerateSimpleTripsURLRequest() {
        do {
            let url = "https://europe-west1-metropolis-fe-test.cloudfunctions.net/api/trips"
            let urlRequest = try urlFactory.makeURLRequest(.trips, .get, nil, nil)
            XCTAssertEqual(url, urlRequest.url!.absoluteString)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
