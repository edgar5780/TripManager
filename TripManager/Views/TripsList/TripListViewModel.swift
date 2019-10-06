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

final class TripListViewModel: ObservableObject {
    @Published var dataSource: [TripListRowView.UIModel]
    private let getTripsUseCase: GetTripsUseCase
    private var disposables = Set<AnyCancellable>()

    init(_ getTripsUseCase: GetTripsUseCase) {
        self.getTripsUseCase = getTripsUseCase
        dataSource = []
    }

    func fetch() {
        getTripsUseCase.invoke()
            .map { trips in
                trips.map { trip in
                    TripListRowView.UIModel(driverName: trip.driverName,
                                            description: trip.description,
                                            origin: trip.origin.address,
                                            destination: trip.destination.address,
                                            startDate: "",
                                            endDate: "")
                }
        }
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { [weak self] completion in
            guard let self = self else { return }
            switch completion {
            case .failure(let error):
                print(error)
                self.dataSource = []
            case .finished:
                break
            }
            }, receiveValue: { [weak self] trips in
                guard let self = self else { return }
                self.dataSource = trips
        }).store(in: &disposables)
    }
}
