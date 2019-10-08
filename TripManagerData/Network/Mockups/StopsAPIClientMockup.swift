//
//  StopsAPIClientMockup.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 08/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine
import TripManagerDomain

final class StopsAPIClientMockup: APIClient {
    func request<T: Decodable>(_ urlRequest: URLRequest) -> AnyPublisher<T, TripManagerError> {
        JSONReader().read("stop")
    }
}
