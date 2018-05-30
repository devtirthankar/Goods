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
    static let registration = "user"
    static let login = "login"
    static let updatename = "name"
    static let updateemail = "email"
    static let updatepassword = "password"
    static let otp = "otp"
    static let listCountries = "countries"
    static let stores = "stores"
    static let products = "products"
    static let rating = "rating"
    static let orders = "orders"
    static let placeorders = "order"
    static let productsbystore = "/productsbystore"
    static let productsbyid = "/productsbyid"
    static let productsbyrating = "/productsbyrating"
    static let imageurlproduction = "https://api.goods-dts.com"
    static let imageurldevelopment = "https://api.smj.ltd/"
}

enum GDServerURL: String {
    case development = "https://api.smj.ltd/api/v1/"
    case test = "test"
    case production = "https://api.goods-dts.com/api/v1/"
    case staging = "http://www.goods-dts.com/goodsapp/"
}

class GDWebServiceManager: NSObject {
    var serviceArray = [GDWebServiceRequest]()
    var baseURL = GDServerURL.production.rawValue
    var baseImageURL = GDWebServiceURLEndPoints.imageurlproduction
    
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
        /*
        if self.serviceArray.contains(ser) == true{
            self.serviceArray.remove(object: ser)
        }*/
        self.serviceArray.remove(object: ser)
        print("service pending = \(self.serviceArray.count)")
    }
}

extension GDWebServiceManager{
    
    func registerUser(name : String, email: String, password: String, phone: String, countrycode: String, block : @escaping GDWSCompletionBlock){
        let service = GDWSRegistrationRequest.init(manager: self, name: name, email: email, password: password, phone: phone, countrycode: countrycode, block: block)
        self.startRequest(service: service)
    }
    
    func listCountries(block : @escaping GDWSCompletionBlock) {
        let service = GDWSCountryCodeRequest(manager: self, block: block)
        self.startRequest(service: service)
    }
    
    func loginUser(mobile: String, password: String, block : @escaping GDWSCompletionBlock) {
        let service = GDWSLoginRequest.init(manager: self, mobile: mobile, password: password, block: block)
        self.startRequest(service: service)
    }
    
    func validateOTP(otp: String, block : @escaping GDWSCompletionBlock) {
        let service = GDWSOTPValidationRequest(manager: self, otp: otp, block: block)
        self.startRequest(service: service)
    }
    
    func updateName(name: String, block : @escaping GDWSCompletionBlock) {
        let service = GDWSUpdateNameRequest(manager: self, name: name, block: block)
        self.startRequest(service: service)
    }
    
    func updateEmail(email: String, block : @escaping GDWSCompletionBlock) {
        let service = GDWSUpdateEmailRequest(manager: self, email: email, block: block)
        self.startRequest(service: service)
    }
    
    func updatePassword(oldpassword: String, newpassword: String, block : @escaping GDWSCompletionBlock) {
        let service = GDWSUpdatePasswordRequest(manager: self, oldpassword: oldpassword, newpassword: newpassword, block: block)
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
    
    func getProductsForStore(storeId: Int64, block : @escaping GDWSCompletionBlock) {
        let service = GDWSProductsForStoreRequest(manager: self, storeId: storeId, block: block)
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
