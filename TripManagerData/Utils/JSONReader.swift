//
//  JSONReader.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 05/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine
import TripManagerDomain

final class JSONReader {
    func read<T: Decodable>(_ fileName: String) -> AnyPublisher<T, TripManagerError> {
        if let path = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let object = try decoder.decode(T.self, from: data)
                return Just(object).setFailureType(to: TripManagerError.self).eraseToAnyPublisher()
            } catch {
                let errorDescription = error.localizedDescription
                return Fail(error: TripManagerError.parse(description: errorDescription)).eraseToAnyPublisher()
            }
        } else {
            return Fail(error: TripManagerError.fileNotFound).eraseToAnyPublisher()
        }
    }
}
