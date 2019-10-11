//
//  BaseDataModel.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 11/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation

protocol BaseDataModel {
    associatedtype DomainModel

    func toDomain() -> DomainModel
}
