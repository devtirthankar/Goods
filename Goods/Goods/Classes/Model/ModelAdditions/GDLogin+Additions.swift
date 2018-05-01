//
//  GDLogin+Additions.swift
//  Goods
//
//  Created by nabanita on 01/05/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation
import CoreData

extension GDLogin {
    convenience init(dictionary: [String: Any], moc: NSManagedObjectContext?) {
        GDStorage.sharedStorage.deleteEntityFromDBEntityName("GDLogin")
        self.init(entity: NSEntityDescription.entity(forEntityName: "GDLogin", in: moc!)!, insertInto: moc!)
        self.token = dictionary["token"] as? String
        self.uuid = dictionary["uuid"] as? String
        
        let userProfile = GDUserProfile(dictionary: dictionary, moc: moc)
        self.user = userProfile
    }
    
    public static func loggedInUser() -> GDLogin?{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GDLogin")
        weak var moc = GDStorage.sharedStorage.moc
        var entity : GDLogin? = nil
        moc?.performAndWait({
            do{
                let objects = try moc?.fetch(request) as? [GDLogin]
                if let objects = objects{
                    if objects.count > 0{
                        entity = objects.last
                    }
                }
            }catch{}
        })
        return entity
    }
}
