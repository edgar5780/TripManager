//
//  MapView.swift
//  TripManager
//
//  Created by Edgar Luis Diaz on 06/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var annotations: [Annotation]

    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        updateAnnotations(from: view)
    }

    private func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        let newAnnotations = annotations.map { annotation in
            TripAnnotation(annotation.address,
                           CLLocationCoordinate2D(latitude: annotation.coordinates.latidude,
                                                  longitude: annotation.coordinates.longitude))
        }
        mapView.addAnnotations(newAnnotations)
        mapView.fitAll()
    }
}

extension MapView {
    struct Annotation {
        var address: String
        var coordinates: (latidude: Double, longitude: Double)
    }
}
