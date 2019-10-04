//
//  Decoder.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 04/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine
import TripManagerDomain

final class Decoder {
    func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, TripManagerError> {
        let decoder = JSONDecoder()
        return Just(data)
            .decode(type: T.self, decoder: decoder)
            .mapError({ .parse(description: $0.localizedDescription) })
            .eraseToAnyPublisher()
    }
}
