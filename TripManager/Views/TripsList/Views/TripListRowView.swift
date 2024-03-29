//
//  TripListRowView.swift
//  TripManager
//
//  Created by Edgar Luis Diaz on 07/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import SwiftUI

struct TripListRowView: View {
    private let uiModel: UIModel

    init(_ uiModel: UIModel) {
        self.uiModel = uiModel
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(uiModel.description)
                .foregroundColor(.customOrange)
                .bold()
                .lineLimit(2)
            HStack {
                Image("origin")
                Text(uiModel.origin)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .bold()
                Spacer()
                Text(uiModel.startDate)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            HStack {
                Image("destination")
                Text(uiModel.destination)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .bold()
                Spacer()
                Text(uiModel.endDate)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Text("\(Strings.driverName.localize(uiModel.driverName))")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

extension TripListRowView {
    struct UIModel: Identifiable {
        var id: UUID
        var driverName: String
        var description: String
        var origin: String
        var destination: String
        var startDate: String
        var endDate: String

        init(driverName: String,
             description: String,
             origin: String,
             destination: String,
             startDate: String,
             endDate: String) {
            id = UUID()
            self.driverName = driverName
            self.description = description
            self.origin = origin
            self.destination = destination
            self.startDate = startDate
            self.endDate = endDate
        }
    }
}
