//
//  StopsLocalDataSourceImp.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 09/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine
import TripManagerDomain

final class StopsLocalDataSourceImp: StopsLocalDataSource {
    private let cache: NSCache<NSString, StopDetailsCache>

    init() {
        cache = NSCache()
    }

    func saveInCache(_ id: Int, _ stop: StopDetails) {
        let stopCache = StopDetailsCache(stop)
        let id = NSString(string: String(id))
        cache.setObject(stopCache, forKey: id)
    }

    func getStopDetails(_ id: Int) -> AnyPublisher<StopDetails, TripManagerError> {
        if let stopDetails = cache.object(forKey: NSString(string: String(id)))?.stop {
            return Just(stopDetails).setFailureType(to: TripManagerError.self).eraseToAnyPublisher()
        } else {
            return Fail(error: TripManagerError.elementNotFound).eraseToAnyPublisher()
        }
    }
}

extension StopsLocalDataSourceImp {
    private final class StopDetailsCache {
        var stop: StopDetails
        init(_ stop: StopDetails) {
            self.stop = stop
        }
    }
}
