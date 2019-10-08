//
//  APIEndpoint.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 05/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation

enum APIEndpoint {
    case trips
    case stop(id: Int)

    func path() -> String {
        switch self {
        case .trips:
            return "/trips"
        case .stop(let id):
            return "/stops/\(id)"
        }
    }
}
