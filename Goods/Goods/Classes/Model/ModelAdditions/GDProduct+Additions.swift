//
//  GDProduct+Additions.swift
//  Goods
//
//  Created by nabanita on 01/05/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation
import CoreData
extension GDProduct {
    convenience init(dictionary: [String: Any], moc: NSManagedObjectContext?) {
        self.init(entity: NSEntityDescription.entity(forEntityName: "GDProduct", in: moc!)!, insertInto: moc!)
        self.name = dictionary["productname"] as? String
        self.productid = dictionary["productid"] as? String
        self.productdescription = dictionary["productdescription"] as? String
    }
}
