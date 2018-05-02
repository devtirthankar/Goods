//
//  GDLogin+CoreDataProperties.swift
//  Goods
//
//  Created by nabanita on 02/05/18.
//  Copyright © 2018 company. All rights reserved.
//
//

import Foundation
import CoreData


extension GDLogin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GDLogin> {
        return NSFetchRequest<GDLogin>(entityName: "GDLogin")
    }

    @NSManaged public var token: String?
    @NSManaged public var uuid: String?
    @NSManaged public var user: GDUserProfile?

}
