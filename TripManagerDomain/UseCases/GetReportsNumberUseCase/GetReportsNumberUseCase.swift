//
//  GetReportsNumberUseCase.swift
//  TripManagerDomain
//
//  Created by Edgar Luis Diaz on 11/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import Combine

public protocol GetReportsNumberUseCase {
    func invoke() -> AnyPublisher<Int, TripManagerError>
}
