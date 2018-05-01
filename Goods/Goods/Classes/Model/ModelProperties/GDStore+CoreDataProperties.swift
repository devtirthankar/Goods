//
//  GDStore+CoreDataProperties.swift
//  Goods
//
//  Created by nabanita on 01/05/18.
//  Copyright © 2018 company. All rights reserved.
//
//

import Foundation
import CoreData


extension GDStore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GDStore> {
        return NSFetchRequest<GDStore>(entityName: "GDStore")
    }

    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var storedescription: String?
    @NSManaged public var storeid: String?

}
