//
//  Container+TripManagerDomain.swift
//  TripManagerDomain
//
//  Created by Edgar Luis Diaz on 06/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Swinject

public extension Container {
    func registerDomain() {
        register(GetTripsAvailableUseCase.self) { resolver in
            let repository = resolver.resolve(TripsRepository.self)!
            return GetTripsAvailableUseCaseImp(repository)
        }
    }
}
