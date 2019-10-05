//
//  BaseRemoteDataSource.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 05/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine
import TripManagerDomain

class BaseRemoteDataSource {
    let apiClient: APIClient

    init(_ apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func apiCall<T: Decodable>(_ endpoint: APIEndpoint,
                               _ method: APIMethod,
                               _ parameters: [String: Any]?,
                               _ queryItems: [String: String]?) -> AnyPublisher<T, TripManagerError> {
        do {
            let urlRequest = try URLFactory().makeURLRequest(endpoint, method, parameters, queryItems)
            return apiClient.request(urlRequest).eraseToAnyPublisher()
        } catch {
            return Fail(error: TripManagerError.badRequest).eraseToAnyPublisher()
        }
    }
}
