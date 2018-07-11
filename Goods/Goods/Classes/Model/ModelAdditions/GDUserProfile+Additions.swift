//
//  GDUserProfile+Additions.swift
//  Goods
//
//  Created by nabanita on 01/05/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation
import CoreData

extension GDUserProfile {
    convenience init(dictionary: [String: Any], moc: NSManagedObjectContext?) {
        GDStorage.sharedStorage.deleteEntityFromDBEntityName("GDUserProfile")
        self.init(entity: NSEntityDescription.entity(forEntityName: "GDUserProfile", in: moc!)!, insertInto: moc!)
        self.name = dictionary["name"] as? String
        //TODO: mobile as string
        //self.mobile = (dictionary["mobile"] as? Int32)!
        if let mobileno = dictionary["mobile"] as? String {
            self.mobile = mobileno
        }else{
            self.mobile = ""
        }
        if let cCode = dictionary["countrycode"] as? Int32 {
            self.countrycode = cCode
        }else{
            self.countrycode = 0
        }
        if let email = dictionary["email"] as? String {
            self.email = email
        }else{
            self.email = ""
        }
    }
    
    public static func loggedInUser() -> GDUserProfile?{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GDUserProfile")
        weak var moc = GDStorage.sharedStorage.moc
        var entity : GDUserProfile? = nil
        moc?.performAndWait({
            do{
                let objects = try moc?.fetch(request) as? [GDUserProfile]
                if let objects = objects{
                    if objects.count > 0{
                        entity = objects.last
                    }
                }
            }catch{}
        })
        return entity
    }
    
    public static func updateUserName(userProfile: GDUserProfile, name: String) {
        userProfile.name = name
    }
    
    public static func updateUserEmail(userProfile: GDUserProfile, email: String) {
        userProfile.email = email
    }
}
