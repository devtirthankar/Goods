//
//  GDWebServiceOrderRequest.swift
//  Goods
//
//  Created by nabanita on 04/05/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation
import Alamofire

struct Orders: Decodable {
    let result: [Order]
}

struct Order: Decodable {
    let orderid: Int64
    let orderstatus: Orderstatus?
    let quantity: Int?
    let userinfo: Userinfo?
    let product: Product
}

struct Orderstatus: Decodable {
    let orderstatusname: String?
    let orderstatusnamear: String?
}

struct Userinfo: Decodable {
    let mobile: String?
    let name: String?
}

class GDWebServiceOrderRequest: GDWebServiceRequest {
    override init(manager: GDWebServiceManager, block : @escaping GDWSCompletionBlock) {
        super.init(manager: manager, block: block)
        httpMethod = HTTPMethod.get
        url = manager.baseURL + GDWebServiceURLEndPoints.orders
        headers?["Authorization"] = "\((GDLogin.loggedInUser()?.token)!)"
    }
}

//This places the user order over the web
class GDWebServicePlaceOrderRequest: GDWebServiceRequest {
    init(manager: GDWebServiceManager, productid: Int64, quantity: Int, block : @escaping GDWSCompletionBlock) {
        super.init(manager: manager, block: block)
        httpMethod = HTTPMethod.post
        url = manager.baseURL + GDWebServiceURLEndPoints.placeorders
        headers?["Authorization"] = "\((GDLogin.loggedInUser()?.token)!)"
        body?["productid"] = productid
        body?["quantity"] = quantity
    }
}
