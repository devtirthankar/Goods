//
//  GDUserProfile+CoreDataProperties.swift
//  Goods
//
//  Created by nabanita on 02/05/18.
//  Copyright © 2018 company. All rights reserved.
//
//

import Foundation
import CoreData


extension GDUserProfile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GDUserProfile> {
        return NSFetchRequest<GDUserProfile>(entityName: "GDUserProfile")
    }

    @NSManaged public var countrycode: Int32
    @NSManaged public var mobile: Int32
    @NSManaged public var name: String?
    @NSManaged public var login: GDLogin?

}
