//
//  Location.swift
//  TripManagerDomain
//
//  Created by Edgar Luis Diaz on 05/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation

public struct Location {
    public var address: String
    public var point: Point

    public init(address: String, point: Point) {
        self.address = address
        self.point = point
    }
}
