//
//  GDStore+Additions.swift
//  Goods
//
//  Created by nabanita on 01/05/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation
import CoreData

extension GDStore {
    convenience init(dictionary: [String: Any], moc: NSManagedObjectContext?) {
        self.init(entity: NSEntityDescription.entity(forEntityName: "GDStore", in: moc!)!, insertInto: moc!)
        self.name = dictionary["storename"] as? String
        self.storeid = dictionary["storeid"] as? String
        self.image = dictionary["logo"] as? String
    }
}

