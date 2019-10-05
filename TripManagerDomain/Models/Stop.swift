//
//  Stop.swift
//  TripManagerDomain
//
//  Created by Edgar Luis Diaz on 05/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation

public struct Stop {
    public var id: Int
    public var point: Point

    public init(id: Int, point: Point) {
        self.id = id
        self.point = point
    }
}
