//
//  PolylineDecoder.swift
//  TripManager
//
//  Created by Edgar Luis Diaz on 08/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import CoreLocation
import Polyline

final class PolylineDecoder {
    func decode(_ polyline: String) -> [CLLocation]? {
        let polylineDecoder = Polyline(encodedPolyline: polyline)
        return polylineDecoder.locations
    }
}
