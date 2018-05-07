//
//  GDWebServiceOrderRequest.swift
//  Goods
//
//  Created by nabanita on 04/05/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation
import Alamofire

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
