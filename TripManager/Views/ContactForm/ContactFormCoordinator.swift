//
//  ContactFormCoordinator.swift
//  TripManager
//
//  Created by Edgar Luis Diaz on 11/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import SwiftUI

final class ContactFormCoordinator {
    func modal() -> some View {
        DependencyInjection.shared.resolve(ContactFormView.self)
    }
}
