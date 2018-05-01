//
//  GDProduct+CoreDataProperties.swift
//  Goods
//
//  Created by nabanita on 01/05/18.
//  Copyright © 2018 company. All rights reserved.
//
//

import Foundation
import CoreData


extension GDProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GDProduct> {
        return NSFetchRequest<GDProduct>(entityName: "GDProduct")
    }

    @NSManaged public var productid: String?
    @NSManaged public var name: String?
    @NSManaged public var productdescription: String?

}
