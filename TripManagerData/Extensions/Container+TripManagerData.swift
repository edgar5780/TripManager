//
//  Container+TripManagerData.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 06/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Swinject
import TripManagerDomain

public extension Container {
    func registerData() {
        registerRepositories()
        registerRemoteDataSource()
        registerLocalDataSource()
        registerAPIClient()
    }

    private func registerRepositories() {
        register(TripsRepository.self) { resolver in
            let remoteDataSource = resolver.resolve(TripsRemoteDataSource.self)!
            return TripsRepositoryImp(remoteDataSource)
        }
        register(StopsRepository.self) { resolver in
            let remoteDataSource = resolver.resolve(StopsRemoteDataSource.self)!
            let localDataSource = resolver.resolve(StopsLocalDataSource.self)!
            return StopsRepositoryImp(remoteDataSource, localDataSource)
        }
        register(ReportsRepository.self) { resolver in
            let localDataSource = resolver.resolve(ReportsLocalDataSource.self)!
            return ReportsRepositoryImp(localDataSource)
        }
    }

    private func registerRemoteDataSource() {
        register(TripsRemoteDataSource.self) { resolver in
            let apiClient = resolver.resolve(APIClient.self)!
            return TripsRemoteDataSourceImp(apiClient)
        }
        register(StopsRemoteDataSource.self) { resolver in
            let apiClient = resolver.resolve(APIClient.self)!
            return StopsRemoteDataSourceImp(apiClient)
        }
    }

    private func registerLocalDataSource() {
        register(StopsLocalDataSource.self) { _ in
            return StopsLocalDataSourceImp()
        }
        register(ReportsLocalDataSource.self) { _ in
            return ReportsLocalDataSourceImp()
        }
    }

    private func registerAPIClient() {
        register(APIClient.self) { _ in
            return APIClientImp()
        }
    }
}
