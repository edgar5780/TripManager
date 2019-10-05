//
//  PointResponse.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 05/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import TripManagerDomain

struct PointResponse: BaseResponseModel {
    var latitude: Double
    var longitude: Double

    enum CodingKeys: String, CodingKey {
        case latitude = "_latitude"
        case longitude = "_longitude"
    }

    func toDomain() -> Point {
        Point(latitude: latitude, longitude: longitude)
    }
}
