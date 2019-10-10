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
    @Published var stopDetails: TripListView.StopDetailsUIModel?
    @Published var annotations: [MapView.Annotation]
    @Published var polylineCoordinates: [MapView.Coordinate]
    @Published var status: Status
    @Published var mapStatus: MapView.Status
    private var trips: [Trip]
    private let getTripsAvailableUseCase: GetTripsAvailableUseCase
    private let getStopUseCase: GetStopUseCase
    private var disposables = Set<AnyCancellable>()

    init(_ getTripsAvailableUseCase: GetTripsAvailableUseCase,
         _ getStopUseCase: GetStopUseCase) {
        self.getTripsAvailableUseCase = getTripsAvailableUseCase
        self.getStopUseCase = getStopUseCase
        dataSource = []
        trips = []
        annotations = []
        polylineCoordinates = []
        status = .loadingTrips
        mapStatus = .needsLoad
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
                    self.status = .empty
                case .finished:
                    break
                }
                }, receiveValue: { [weak self] trips in
                    guard let self = self else { return }
                    self.status = trips.isEmpty ? .empty : .tripList
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
        mapStatus = .needsLoad
        let indexUnwrapped = dataSource.firstIndex(where: { $0.id == id })
        guard let index = indexUnwrapped, index < trips.count else { return }
        let trip = trips[index]
        getAnnotations(trip)
        getPolyline(trip.route)
    }

    func annotationSelected(_ id: Int?) {
        mapStatus = .loaded
        guard let id = id else {
            stopDetails = nil
            status = .tripList
            return
        }
        status = .loadingDetails
        getStopUseCase.invoke(id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure:
                    self.stopDetails = nil
                    self.status = .tripList
                case .finished:
                    self.status = .details
                }
                }, receiveValue: { [weak self] stopDetails in
                    guard let self = self else { return }
                    self.stopDetails = .init(address: stopDetails.address,
                                             stopTime: stopDetails.stopTime.getFormattedDate(),
                                             userName: stopDetails.userName,
                                             price: String(stopDetails.price),
                                             paid: stopDetails.paid)
            }).store(in: &disposables)
    }

    private func getAnnotations(_ trip: Trip) {
        annotations = [.init(address: trip.origin.address,
                             coordinate: .init(latitude: trip.origin.point.latitude,
                                                longitude: trip.origin.point.longitude)),
                       .init(address: trip.destination.address,
                             coordinate: .init(latitude: trip.destination.point.latitude,
                                                longitude: trip.destination.point.longitude))]
        let stopAnnotations = trip.stops.map { stop in
            MapView.Annotation(address: "",
                               coordinate: .init(latitude: stop.point.latitude,
                                                  longitude: stop.point.longitude),
                               id: stop.id)
        }
        annotations.append(contentsOf: stopAnnotations)
    }

    private func getPolyline(_ polyline: String) {
        let polylineCoordinates = PolylineDecoder().decode(polyline)?.map({ location in
            MapView.Coordinate(latitude: location.coordinate.latitude,
                               longitude: location.coordinate.longitude)
        })
        guard let polyline = polylineCoordinates else { return }
        self.polylineCoordinates = polyline
    }
}

extension TripListViewModel {
    enum Status {
        case loadingTrips
        case tripList
        case empty
        case loadingDetails
        case details
    }
}
