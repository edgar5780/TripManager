//
//  APIClientImp.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 04/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine
import TripManagerDomain

final class APIClientImp: APIClient {
    private let session: URLSession

    init(_ session: URLSession = .shared) {
        self.session = session
    }

    func request<T: Decodable>(_ urlRequest: URLRequest) -> AnyPublisher<T, TripManagerError> {
        return session.dataTaskPublisher(for: urlRequest)
            .mapError({ .api(description: $0.localizedDescription) })
            .flatMap { response in
                Decoder().decode(response.data)
        }.eraseToAnyPublisher()
    }
}
