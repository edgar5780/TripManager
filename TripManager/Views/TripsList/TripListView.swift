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
            MapView(annotations: $viewModel.annotations,
                    polylineCoordinates: $viewModel.polylineCoordinates,
                    status: $viewModel.mapStatus) { id in
                        self.viewModel.annotationSelected(id)
            }
            if viewModel.status == .loading {
                loadingView
            } else if viewModel.status == .tripList {
                tripsList
            } else if viewModel.status == .empty {
                emptySection
            } else if viewModel.status == .details {
                detailsView
            }
        }.edgesIgnoringSafeArea(.top)
    }

    var loadingView: some View {
        VStack {
            Spacer()
            ActivityIndicatorView()
            Spacer()
        }
    }

    var emptySection: some View {
        VStack {
            Spacer()
            Text(Strings.noResults.localize())
                .font(.title)
                .foregroundColor(.customOrange)
                .bold()
            Spacer()
        }
    }

    var tripsList: some View {
        List(viewModel.dataSource) { item in
            Button(action: {
                self.viewModel.itemSelected(item.id)
            }, label: {
                TripListRowView(item)
            })
        }
    }

    var detailsView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Spacer()
            Text(viewModel.stopDetails?.address ?? "")
                .foregroundColor(.customOrange)
                .bold()
            Text(viewModel.stopDetails?.stopTime.getFormattedDate() ?? "")
                .foregroundColor(.gray)
            HStack {
                Text(viewModel.stopDetails?.userName ?? "")
                    .foregroundColor(.gray)
                Spacer()
                Group {
                    Text(viewModel.stopDetails?.paid ?? false ? "Paid" : "Not paid")
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3))
                }.background(viewModel.stopDetails?.paid ?? false ? Color.green : Color.red)
                    .cornerRadius(5)
            }
            Spacer()
        }.padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
    }
}
