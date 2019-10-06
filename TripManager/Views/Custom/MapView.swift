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
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }

    func updateUIView(_ view: MKMapView, context: Context) { }
}
