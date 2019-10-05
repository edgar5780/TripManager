//
//  LocationResponse.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 05/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import TripManagerDomain

struct LocationResponse: BaseResponseModel {
    var address: String
    var point: PointResponse

    func toDomain() -> Location {
        Location(address: address, point: point.toDomain())
    }
}
