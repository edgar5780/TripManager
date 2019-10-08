//
//  StopDetails.swift
//  TripManagerDomain
//
//  Created by Edgar Luis Diaz on 08/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation

public struct StopDetails {
    public var stopTime: Date
    public var paid: Bool
    public var address: String
    public var userName: String
    public var point: Point
    public var price: Double

    public init(stopTime: Date,
                paid: Bool,
                address: String,
                userName: String,
                point: Point,
                price: Double) {
        self.stopTime = stopTime
        self.paid = paid
        self.address = address
        self.userName = userName
        self.point = point
        self.price = price
    }
}
