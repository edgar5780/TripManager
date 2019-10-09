//
//  TripManagerError.swift
//  TripManagerDomain
//
//  Created by Edgar Luis Diaz on 04/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation

public enum TripManagerError: Error {
    case generic
    case badRequest
    case parse(description: String)
    case api(description: String)
    case fileNotFound
    case elementNotFound
}
