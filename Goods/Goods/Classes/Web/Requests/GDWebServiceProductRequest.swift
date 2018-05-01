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
    
    override init(manager: GDWebServiceManager, block : @escaping GDWSCompletionBlock) {
        super.init(manager: manager, block: block)
        httpMethod = HTTPMethod.get
        url = manager.baseURL + GDWebServiceURLEndPoints.products
        headers?["Authorization"] = "\((GDLogin.loggedInUser()?.token)!)"
    }
    
    override func responseSuccess(data: Any?) {
        GDStorage.sharedStorage.deleteEntityFromDBEntityName("GDProduct")
        var products = [GDProduct]()
        if let json = data as? [String: Any]{
            if let list = json["result"] as? [[String: Any]]{
                let moc = GDStorage.sharedStorage.moc
                moc?.performAndWait {
                    for info in list {
                        let product = GDProduct.init(dictionary: info, moc: moc)
                        products.append(product)
                    }
                }
            }
            GDStorage.sharedStorage.saveMOCToStorage()
        }
        super.responseSuccess(data: products)
    }
    
    /*
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
 */
    
}
