//
//  GDWebServiceProductRequest.swift
//  Goods
//
//  Created by nabanita on 06/04/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation
import Alamofire

struct Products: Decodable {
    let result: [Product]
}

struct Product: Decodable, Equatable {
    let price: Float32?
    let productcategory: ProductCategory?
    let productdescription: String?
    let productid: Int64
    let productimages: [ProductImage]?
    let productname: String?
    let productnamear: String?
    let productstatus: ProductStatus?
    let quantity: Int32?
    let serialnumber: String?
    let storeInfo: StoreInfo?
    
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.productid == rhs.productid
    }
}

struct ProductCategory: Decodable {
    let productcategoryname: String
    let productcategorynamear: String
}

struct ProductImage: Decodable {
    let imgpath: URL
}

struct ProductStatus: Decodable {
    let productstatusname: String
    let productstatusnamear: String
}

struct StoreInfo: Decodable {
    let delivery: Bool
    let storeid: Int64
    let storename: String
    let storenamear: String
}

class GDWebServiceProductRequest: GDWebServiceRequest {
    
    override init(manager: GDWebServiceManager, block : @escaping GDWSCompletionBlock) {
        super.init(manager: manager, block: block)
        httpMethod = HTTPMethod.get
        url = manager.baseURL + GDWebServiceURLEndPoints.products
        headers?["Authorization"] = "\((GDLogin.loggedInUser()?.token)!)"
    }
}

class GDWebServiceRateProductRequest: GDWebServiceRequest {
    
    init(manager: GDWebServiceManager, rating: Float, productId: Int64, block : @escaping GDWSCompletionBlock) {
        super.init(manager: manager, block: block)
        httpMethod = HTTPMethod.post
        url = manager.baseURL + GDWebServiceURLEndPoints.rating
        headers?["Authorization"] = "\((GDLogin.loggedInUser()?.token)!)"
        body?["rating"] = rating
        body?["productid"] = productId
    }
    
}

