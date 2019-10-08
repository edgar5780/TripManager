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
    @Binding var polylineCoordinates: [Coordinates]

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        updateAnnotations(view)
        updatePolyline(view)
    }

    private func updateAnnotations(_ mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        guard !annotations.isEmpty else { return }
        let newAnnotations = annotations.map { annotation in
            TripAnnotation(annotation.address,
                           CLLocationCoordinate2D(latitude: annotation.coordinates.latitude,
                                                  longitude: annotation.coordinates.longitude))
        }
        mapView.addAnnotations(newAnnotations)
        mapView.fitAll()
    }

    private func updatePolyline(_ mapView: MKMapView) {
        mapView.removeOverlays(mapView.overlays)
        guard !polylineCoordinates.isEmpty else { return }
        let polylineCoordinates = self.polylineCoordinates.map { coordinates in
            CLLocationCoordinate2D(latitude: coordinates.latitude,
                                   longitude: coordinates.longitude)
        }
        let geodesic = MKGeodesicPolyline(coordinates: polylineCoordinates, count: polylineCoordinates.count)
        mapView.addOverlay(geodesic)
    }
}

extension MapView {
    struct Annotation {
        var address: String
        var coordinates: Coordinates
    }

    struct Coordinates {
        var latitude: Double
        var longitude: Double
    }

    final class Coordinator: NSObject, MKMapViewDelegate {
        var control: MapView

        init(_ control: MapView) {
            self.control = control
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = .red
            polylineRenderer.lineWidth = 5
            return polylineRenderer
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let reuseIdentifier = "annotationView"
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
            if view == nil {
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            }
            view?.displayPriority = .required
            view?.annotation = annotation
            return view
        }
    }
}
