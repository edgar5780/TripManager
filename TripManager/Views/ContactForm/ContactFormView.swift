//
//  ContactFormView.swift
//  TripManager
//
//  Created by Edgar Luis Diaz on 10/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import SwiftUI
import Combine

struct ContactFormView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var viewModel: ContactFormViewModel

    init(_ viewModel: ContactFormViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField(Strings.name.localize(), text: $viewModel.name)
                    TextField(Strings.surname.localize(), text: $viewModel.surname)
                    TextField(Strings.email.localize(), text: $viewModel.email)
                        .keyboardType(.emailAddress)
                    TextField(Strings.phone.localize(), text: $viewModel.phone)
                        .keyboardType(.phonePad)
                    DatePicker(selection: $viewModel.date) {
                        Text(Strings.date.localize())
                    }
                    TextField(Strings.details.localize(), text: $viewModel.details)
                }
            }.navigationBarTitle(Text(Strings.contactForm.localize()), displayMode: .inline)
                .navigationBarItems(leading: cancelButton, trailing: saveButton)
        }
    }

    var cancelButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Text(Strings.cancel.localize())
        })
    }

    var saveButton: some View {
        Button(action: {
            self.viewModel.save()
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Text(Strings.save.localize())
                .bold()
        }).disabled(viewModel.saveDisabled)
    }
}
