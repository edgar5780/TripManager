//
//  Container+TripManager.swift
//  TripManager
//
//  Created by Edgar Luis Diaz on 07/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Swinject
import TripManagerDomain
import TripManagerData

extension Container {
    func registerApp() {
        registerViews()
        registerViewModels()
    }

    private func registerViews() {
        register(TripListView.self) { resolver in
            let viewModel = resolver.resolve(TripListViewModel.self)!
            return TripListView(viewModel)
        }
    }

    private func registerViewModels() {
       register(TripListViewModel.self) { resolver in
           let getTripsAvailableUseCase = resolver.resolve(GetTripsAvailableUseCase.self)!
           return TripListViewModel(getTripsAvailableUseCase)
       }
    }
}