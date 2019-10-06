//
//  DependencyInjection.swift
//  TripManager
//
//  Created by Edgar Luis Diaz on 07/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Swinject

final class DependencyInjection {
    static let shared = DependencyInjection()
    private let container: Container

    private init() {
        self.container = Container()
        register()
    }

    func resolve<Service>(_ serviceType: Service.Type) -> Service {
        guard let service = container.resolve(serviceType) else {
            fatalError("Missing dependencies")
        }
        return service
    }

    private func register() {
        container.registerApp()
        container.registerDomain()
        container.registerData()
    }
}
