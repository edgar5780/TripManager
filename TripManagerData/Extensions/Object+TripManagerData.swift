//
//  Object+TripManagerData.swift
//  TripManagerData
//
//  Created by Edgar Luis Diaz on 11/10/2019.
//  Copyright © 2019 Edgar. All rights reserved.
//

import Foundation
import RealmSwift

extension Object {
    @objc func save(_ update: Bool) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(self, update: update ? .all : .error)
            try realm.commitWrite()
        } catch {}
    }
}
