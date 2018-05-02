//
//  GDWebServiceStoreRequest.swift
//  Goods
//
//  Created by nabanita on 01/05/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation
import Alamofire

struct Stores: Decodable {
    let result: [Store]
}

struct Store: Decodable {
    let addresses: [StoreAddress]?
    let agreement: String?
    let logo: URL?
    let registrationcertificate: String?
    let slogan: String?
    let storecategory: StoreCategory?
    let storeid: Int64
    let storename: String?
    let storenamear: String?
    let storestatus: StoreStatus?
}

struct StoreCategory: Decodable {
    let storecategoryname: String
    let storecategorynamear: String
}

struct StoreStatus: Decodable {
    let storestatusname: String
    let storestatusnamear: String
}

struct StoreAddress: Decodable {
    let address: String
    let delivery: Bool
    let lat: Double
    let lng: Double
    let schedule: Schedule
    let zipcode: String
}

struct Schedule: Decodable {
    let sunday: Bool
    let monday: Bool
    let tuesday: Bool
    let wednesday: Bool
    let thursday: Bool
    let friday: Bool
    let workstarttime: String
    let workstoptime: String
}

class GDWebServiceStoreRequest: GDWebServiceRequest {
    override init(manager : GDWebServiceManager, block : @escaping GDWSCompletionBlock) {
        super.init(manager: manager, block: block)
        httpMethod = HTTPMethod.get
        url = manager.baseURL + GDWebServiceURLEndPoints.stores
        headers?["Authorization"] = "\((GDLogin.loggedInUser()?.token)!)"
    }
    
    override func responseSuccess(data: Data?) {
        guard let data = data else {
            print("No product data")
            return
        }
        
        guard let stores = try? JSONDecoder().decode(Stores.self, from: data) else {
            print("Error: Couldn't decode data into Product")
            return
        }
        print("\(stores.result)")
        /*--New
        GDStorage.sharedStorage.deleteEntityFromDBEntityName("GDStore")
        var stores = [GDStore]()
        if let json = data as? [String: Any]{
            if let list = json["result"] as? [[String: Any]]{
                let moc = GDStorage.sharedStorage.moc
                moc?.performAndWait {
                    for info in list {
                        let store = GDStore.init(dictionary: info, moc: moc)
                        stores.append(store)
                    }
                }
            }
            GDStorage.sharedStorage.saveMOCToStorage()
        }
        super.responseSuccess(data: stores)*/
    }
}
