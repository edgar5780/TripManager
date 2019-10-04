//
//  URLFactory.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 05/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import TripManagerDomain

final class URLFactory {
    private let scheme = "https"
    private let host = "europe-west1-metropolis-fe-test.cloudfunctions.net"
    private let path = "/api"

    func makeURLRequest(_ endpoint: APIEndpoint,
                        _ method: APIMethod,
                        _ parameters: [String: Any]?,
                        _ queryItems: [String: String]?) throws -> URLRequest {
        if let url = urlComponents(endpoint, queryItems).url {
            return urlRequest(url, method, parameters)
        } else {
            throw TripManagerError.badRequest
        }
    }

    private func urlComponents(_ endpoint: APIEndpoint,
                               _ queryItems: [String: String]?) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.host = host
        urlComponents.path = "\(path)\(endpoint.path())"
        if let queryItems = queryItems {
            urlComponents.setQueryItems(with: queryItems)
        }
        return urlComponents
    }

    private func urlRequest(_ url: URL,
                            _ method: APIMethod,
                            _ parameters: [String: Any]?) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        if let parameters = parameters,
            let jsonParameters = try? JSONSerialization.data(withJSONObject: parameters,
                                                             options: []) {
            urlRequest.httpBody = jsonParameters
        }
        return urlRequest
    }
}
