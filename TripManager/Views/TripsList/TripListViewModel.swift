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
    @Published var annotations: [MapView.Annotation]
    private var trips: [Trip]
    private let getTripsAvailableUseCase: GetTripsAvailableUseCase
    private var disposables = Set<AnyCancellable>()

    init(_ getTripsAvailableUseCase: GetTripsAvailableUseCase) {
        self.getTripsAvailableUseCase = getTripsAvailableUseCase
        dataSource = []
        trips = []
        annotations = []
    }

    func fetch() {
        getTripsAvailableUseCase.invoke()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure:
                    self.trips = []
                    self.dataSource = []
                case .finished:
                    break
                }
                }, receiveValue: { [weak self] trips in
                    guard let self = self else { return }
                    self.trips = trips
                    self.dataSource = trips.map { trip in
                        TripListRowView.UIModel(driverName: trip.driverName,
                                                description: trip.description,
                                                origin: trip.origin.address,
                                                destination: trip.destination.address,
                                                startDate: trip.startTime.getFormattedDate(),
                                                endDate: trip.endTime.getFormattedDate())
                    }
            }).store(in: &disposables)
    }

    func itemSelected(_ id: UUID) {
        let indexUnwrapped = dataSource.firstIndex(where: { $0.id == id })
        guard let index = indexUnwrapped, index < trips.count else { return }
        let trip = trips[index]
        annotations = [MapView.Annotation(address: trip.origin.address,
                                          coordinates: (trip.origin.point.latitude,
                                                        trip.origin.point.longitude)),
                       MapView.Annotation(address: trip.destination.address,
                                          coordinates: (trip.destination.point.latitude,
                                                        trip.destination.point.longitude))]
    }
}
