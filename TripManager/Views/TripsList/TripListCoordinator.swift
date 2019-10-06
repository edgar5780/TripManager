//
//  TripListCoordinator.swift
//  TripManager
//
//  Created by Edgar Luis Diaz on 07/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import UIKit
import SwiftUI

final class TripListCoordinator {
    private let window: UIWindow?

    init(_ window: UIWindow?) {
        self.window = window
    }

    func start() {
        let tripListView = DependencyInjection.shared.resolve(TripListView.self)
        window?.rootViewController = UIHostingController(rootView: tripListView)
        window?.makeKeyAndVisible()
    }
}
