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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return Just(data)
            .decode(type: T.self, decoder: decoder)
            .mapError({ .parse(description: $0.localizedDescription) })
            .eraseToAnyPublisher()
    }
}
