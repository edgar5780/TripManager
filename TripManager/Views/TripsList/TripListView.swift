//
//  TripListView.swift
//  TripManager
//
//  Created by Edgar Luis Diaz on 04/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import SwiftUI
import MapKit

struct TripListView: View {
    var body: some View {
        VStack {
            MapView()
        }.edgesIgnoringSafeArea(.vertical)
    }
}

struct TripListView_Previews: PreviewProvider {
    static var previews: some View {
        TripListView()
    }
}
