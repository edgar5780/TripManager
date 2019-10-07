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
    @Published var polylineCoordinates: [MapView.Coordinates]
    private var trips: [Trip]
    private let getTripsAvailableUseCase: GetTripsAvailableUseCase
    private var disposables = Set<AnyCancellable>()

    init(_ getTripsAvailableUseCase: GetTripsAvailableUseCase) {
        self.getTripsAvailableUseCase = getTripsAvailableUseCase
        dataSource = []
        trips = []
        annotations = []
        polylineCoordinates = []
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
                        .init(driverName: trip.driverName,
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
        getAnnotations(trip)
        getPolyline(trip.route)
    }

    private func getAnnotations(_ trip: Trip) {
        annotations = [.init(address: trip.origin.address,
                             coordinates: .init(latitude: trip.origin.point.latitude,
                                                longitude: trip.origin.point.longitude)),
                       .init(address: trip.destination.address,
                             coordinates: .init(latitude: trip.destination.point.latitude,
                                                longitude: trip.destination.point.longitude))]
        let stopAnnotations = trip.stops.map { stop in
            MapView.Annotation(address: "",
                               coordinates: .init(latitude: stop.point.latitude,
                                                  longitude: stop.point.longitude))
        }
        annotations.append(contentsOf: stopAnnotations)
    }

    private func getPolyline(_ polyline: String) {
        let polylineCoordinates = PolylineDecoder().decode(polyline)?.map({ location in
            MapView.Coordinates(latitude: location.coordinate.latitude,
                                longitude: location.coordinate.longitude)
        })
        guard let polyline = polylineCoordinates else { return }
        self.polylineCoordinates = polyline
    }
}
