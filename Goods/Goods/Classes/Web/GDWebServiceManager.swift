//
//  GDWebServiceManager.swift
//  Goods
//
//  Created by nabanita on 25/02/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation

typealias GDWSCompletionBlock = (_ object : Any?, _ error : Error?) -> Void

enum GDWebServiceURLEndPoints{
    static let registration = "register"
    static let login = "login"
    static let otp = "otp"
    static let stores = "stores"
    static let products = "products"
    static let rating = "rating"
    static let orders = "orders"
    static let placeorders = "order"
    static let productsbystore = "/productsbystore"
    static let productsbyid = "/productsbyid"
    static let productsbyrating = "/productsbyrating"
}

enum GDServerURL: String {
    case development = "https://api.smj.ltd/api/v1/"
    case test = "test"
    case production = "https://api.goods-dts.com/"
    case staging = "http://www.goods-dts.com/goodsapp"
}

class GDWebServiceManager: NSObject {
    var serviceArray = [GDWebServiceRequest]()
    var baseURL = GDServerURL.development.rawValue
    
    static let sharedManager : GDWebServiceManager = {
        let instance = GDWebServiceManager()
        return instance
    }()
    
    func startRequest(service : GDWebServiceRequest){
        service.start()
        serviceArray.append(service)
        print("services started = \(self.serviceArray.count)")
    }
    
    func stopRequest(service : GDWebServiceRequest){
        service.stop()
    }
    
    func closeService(service : GDWebServiceRequest?){
        guard let ser = service else{
            return
        }
        if self.serviceArray.contains(ser) == true{
            self.serviceArray.remove(object: ser)
        }
        print("service pending = \(self.serviceArray.count)")
    }
    
}

extension GDWebServiceManager{
    
    func registerUser(name : String, email: String, password: String, phone: String, countrycode: String, usertype:String, block : @escaping GDWSCompletionBlock){
        let service = GDWSRegistrationRequest.init(manager: self, name: name, email: email, password: password, phone: phone, countrycode: countrycode, usertype: usertype, block: block)
        self.startRequest(service: service)
    }
    
    func loginUser(mobile: String, password: String, block : @escaping GDWSCompletionBlock) {
        let service = GDWSLoginRequest.init(manager: self, mobile: mobile, password: password, block: block)
        self.startRequest(service: service)
    }
    
    func validateOTP(otp: String, block : @escaping GDWSCompletionBlock) {
        let service = GDOTPValidationRequest(manager: self, otp: otp, block: block)
        self.startRequest(service: service)
    }
    
    func getStores(block : @escaping GDWSCompletionBlock) {
        let service = GDWebServiceStoreRequest.init(manager: self, block: block)
        self.startRequest(service: service)
    }
    
    func getStoresNearYou(latitude: Double, longitude: Double, block : @escaping GDWSCompletionBlock) {
        let service = GDWebServiceStoresNearYouRequest(manager: self, latitude: latitude, longitude: longitude, block: block)
        self.startRequest(service: service)
    }
    
    func getProducts(block : @escaping GDWSCompletionBlock) {
        let service = GDWebServiceProductRequest.init(manager: self, block: block)
        self.startRequest(service: service)
    }
    
    func getOrders(block : @escaping GDWSCompletionBlock) {
        let service = GDWebServiceOrderRequest(manager: self, block: block)
        self.startRequest(service: service)
    }
    
    func placeOrder(productid: Int64, quantity: Int, block : @escaping GDWSCompletionBlock) {
        let service = GDWebServicePlaceOrderRequest(manager: self, productid: productid, quantity: quantity, block: block)
        self.startRequest(service: service)
    }
    
    func rateProduct(productid: Int64, rating: Float, block : @escaping GDWSCompletionBlock) {
        let service = GDWebServiceRateProductRequest(manager: self, rating: rating, productId: productid, block: block)
        self.startRequest(service: service)
    }
}
