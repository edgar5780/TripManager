//
//  StopResponse.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 05/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import TripManagerDomain

struct StopResponse: BaseResponseModel {
    var id: Int?
    var point: PointResponse?

    // Return type is optional to solve when the API sends empty objects
    func toDomain() -> Stop? {
        guard let id = id, let point = point else { return nil }
        return Stop(id: id, point: point.toDomain())
    }
}
