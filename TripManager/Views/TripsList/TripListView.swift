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
    @State private var showContactForm = false

    init(_ viewModel: TripListViewModel) {
        self.viewModel = viewModel
        viewModel.fetch()
    }

    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                if viewModel.status == .loadingDetails {
                    loadingView
                } else if viewModel.status == .details {
                    detailsView
                }
                MapView(annotations: $viewModel.annotations,
                        polylineCoordinates: $viewModel.polylineCoordinates,
                        status: $viewModel.mapStatus) { id in
                            self.viewModel.annotationSelected(id)
                }.edgesIgnoringSafeArea(.top)
                if viewModel.status == .loadingTrips {
                    loadingView
                } else if viewModel.status == .empty {
                    emptySection
                } else {
                    tripsList
                }
            }
            if !(viewModel.status == .loadingDetails || viewModel.status == .details) {
                contactFormButton
            }
        }
    }

    var loadingView: some View {
        VStack {
            if viewModel.status == .loadingTrips {
                Spacer()
            }
            ActivityIndicatorView()
            if viewModel.status == .loadingTrips {
                Spacer()
            }
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
        VStack(alignment: .leading, spacing: 5) {
            Text(viewModel.stopDetails?.address ?? "")
                .foregroundColor(.customOrange)
                .bold()
            Text(viewModel.stopDetails?.stopTime ?? "")
                .font(.caption)
                .foregroundColor(.gray)
            HStack {
                Text(viewModel.stopDetails?.userName ?? "")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
                Text(viewModel.stopDetails?.price ?? "")
                    .font(.caption)
                    .foregroundColor(.gray)
                Group {
                    Text(viewModel.stopDetails?.paid ?? false ?
                        Strings.paid.localize() : Strings.notPaid.localize())
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.all, 3)
                }.background(viewModel.stopDetails?.paid ?? false ? Color.green : Color.red)
                    .cornerRadius(5)
            }
        }.padding(.all, 12)
    }

    var contactFormButton: some View {
        HStack {
            Spacer()
            Button(action: {
                self.showContactForm = true
            }, label: {
                Image("contact")
                    .frame(width: 50, height: 50, alignment: .center)
            }).background(Color.customOrange)
                .cornerRadius(25)
                .padding()
                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                .sheet(isPresented: $showContactForm,
                       content: { ContactFormView() })
        }
    }
}

extension TripListView {
    struct StopDetailsUIModel {
        var address: String
        var stopTime: String
        var userName: String
        var price: String
        var paid: Bool
    }
}
