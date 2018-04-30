//
//  GDWebServiceProductRequest.swift
//  Goods
//
//  Created by nabanita on 06/04/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation
import Alamofire

class GDWebServiceProductRequest: GDWebServiceRequest {
    
    //products by store
    init(manager: GDWebServiceManager, storeId: Int64, block : @escaping GDWSCompletionBlock) {
        super.init(manager: manager, block: block)
        httpMethod = HTTPMethod.get
        url = manager.baseURL + GDWebServiceURLEndPoints.productsbystore + "/\(storeId)"
    }
    
    //products by id
    init(manager: GDWebServiceManager, productId: Int64, block : @escaping GDWSCompletionBlock) {
        super.init(manager: manager, block: block)
        httpMethod = HTTPMethod.get
        url = manager.baseURL + GDWebServiceURLEndPoints.productsbyid + "/\(productId)"
    }
    
    //products by rating
    init(manager: GDWebServiceManager, rating: Float, block : @escaping GDWSCompletionBlock) {
        super.init(manager: manager, block: block)
        httpMethod = HTTPMethod.get
        url = manager.baseURL + GDWebServiceURLEndPoints.productsbyrating + "/\(rating)"
    }
    
}
