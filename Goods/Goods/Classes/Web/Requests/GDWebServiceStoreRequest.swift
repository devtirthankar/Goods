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
}

class GDWebServiceStoresNearYouRequest: GDWebServiceRequest {
    init(manager: GDWebServiceManager, latitude: Double, longitude: Double, block: @escaping GDWSCompletionBlock) {
        super.init(manager: manager, block: block)
        httpMethod = HTTPMethod.post
        url = manager.baseURL + GDWebServiceURLEndPoints.stores
        headers?["Authorization"] = "\((GDLogin.loggedInUser()?.token)!)"
        body?["lat"] = latitude
        body?["lng"] = longitude
    }
}
