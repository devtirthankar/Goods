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

struct Product: Decodable {
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
    
    override func responseSuccess(data: Data?) {
        guard let data = data else {
            print("No product data")
            return
        }
        
        guard let product = try? JSONDecoder().decode(Products.self, from: data ) else {
            print("Error: Couldn't decode data into Product")
            return
        }
        
        print("Product :" + "\(product.result) ")
//        GDStorage.sharedStorage.deleteEntityFromDBEntityName("GDProduct")
//        var products = [GDProduct]()
//        if let json = data as? [String: Any]{
//            if let list = json["result"] as? [[String: Any]]{
//                let moc = GDStorage.sharedStorage.moc
//                moc?.performAndWait {
//                    for info in list {
//                        let product = GDProduct.init(dictionary: info, moc: moc)
//                        products.append(product)
//                    }
//                }
//            }
//            GDStorage.sharedStorage.saveMOCToStorage()
//        }
//        super.responseSuccess(data: products)
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
