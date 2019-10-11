//
//  SaveReportUseCase.swift
//  TripManagerDomain
//
//  Created by Edgar Luis Diaz on 11/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation

public protocol SaveReportUseCase {
    func invoke(_ report: Report)
}
