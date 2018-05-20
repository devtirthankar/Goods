//
//  GDUserProfile+CoreDataProperties.swift
//  Goods
//
//  Created by nabanita on 17/05/18.
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
    @NSManaged public var mobile: String?
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var login: GDLogin?

}
