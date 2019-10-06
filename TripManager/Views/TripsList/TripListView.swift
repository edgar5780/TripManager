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
    @ObservedObject private var viewModel: TripListViewModel

    init(_ viewModel: TripListViewModel) {
        self.viewModel = viewModel
        viewModel.fetch()
    }

    var body: some View {
        VStack {
            MapView()
            List {
                if viewModel.dataSource.isEmpty {
                    emptySection
                } else {
                    tripssSection
                }
            }
        }.edgesIgnoringSafeArea(.vertical)
    }

    var emptySection: some View {
        Section {
            Text("No results")
        }
    }

    var tripssSection: some View {
        ForEach(viewModel.dataSource, content: TripListRowView.init(_:))
    }
}
