//
//  TripListViewModel.swift
//  TripManager
//
//  Created by Edgar Luis Diaz on 07/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine
import TripManagerDomain

final class TripListViewModel {
    private let getTripsUseCase: GetTripsUseCase

    init(_ getTripsUseCase: GetTripsUseCase) {
        self.getTripsUseCase = getTripsUseCase
    }
}
