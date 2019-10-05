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

    func testGenerateTripsURLRequestWithQueryItems() {
        do {
            let url = "https://europe-west1-metropolis-fe-test.cloudfunctions.net/api/trips?"
            let param1 = "param1=value1"
            let param2 = "param2=value%202"
            let urlRequest = try urlFactory.makeURLRequest(.trips,
                                                           .get,
                                                           nil,
                                                           ["param1": "value1", "param2": "value 2"])
            XCTAssertTrue(urlRequest.url!.absoluteString.contains(url))
            XCTAssertTrue(urlRequest.url!.absoluteString.contains(param1))
            XCTAssertTrue(urlRequest.url!.absoluteString.contains(param2))
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    // swiftlint:disable force_cast
    func testGenerateTripsURLRequestWithPostParams() {
        do {
            let url = "https://europe-west1-metropolis-fe-test.cloudfunctions.net/api/trips"
            let param1 = "value1"
            let param2 = 2
            let urlRequest = try urlFactory.makeURLRequest(.trips,
                                                           .post,
                                                           ["param1": "value1", "param2": 2],
                                                           nil)
            let params = try JSONSerialization.jsonObject(with: urlRequest.httpBody!,
                                                          options: .allowFragments) as! [String: Any]
            XCTAssertEqual(url, urlRequest.url!.absoluteString)
            XCTAssertEqual(param1, params["param1"] as! String)
            XCTAssertEqual(param2, params["param2"] as! Int)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
