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

    func path() -> String {
        switch self {
        case .trips:
            return "/trips"
        }
    }
}
