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
        guard service != nil else{
            return
        }
        if self.serviceArray.contains(service!) == true{
            self.serviceArray.remove(object: service!)
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
    
}
