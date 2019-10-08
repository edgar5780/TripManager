//
//  StopDetailsResponse.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 08/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import TripManagerDomain

struct StopDetailsResponse: BaseResponseModel {
    var stopTime: Date
    var paid: Bool
    var address: String
    var userName: String
    var point: PointResponse
    var price: Double

    func toDomain() -> StopDetails {
        StopDetails(stopTime: stopTime,
                    paid: paid,
                    address: address,
                    userName: userName,
                    point: point.toDomain(),
                    price: price)
    }
}
