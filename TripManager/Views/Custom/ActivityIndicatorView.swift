//
//  ActivityIndicatorView.swift
//  TripManager
//
//  Created by Edgar Luis Diaz on 08/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = .customOrange
        return activityIndicator
    }

    func updateUIView(_ view: UIActivityIndicatorView, context: Context) {
        view.startAnimating()
    }
}
