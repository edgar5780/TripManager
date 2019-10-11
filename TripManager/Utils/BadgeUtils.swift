//
//  BadgeUtils.swift
//  TripManager
//
//  Created by Edgar Luis Diaz on 11/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import UIKit

final class BadgeUtils {
    func updateBadge(_ number: Int) {
        UIApplication.shared.applicationIconBadgeNumber = number
    }
}
