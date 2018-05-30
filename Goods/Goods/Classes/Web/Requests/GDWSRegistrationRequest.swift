//
//  GDWSRegistrationRequest.swift
//  Goods
//
//  Created by nabanita on 25/02/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation
import Alamofire

class GDWSRegistrationRequest: GDWebServiceRequest {
    
    init(manager : GDWebServiceManager, name : String, email: String, password: String, phone: String, countrycode: String, block : @escaping GDWSCompletionBlock) {
        
        super.init(manager: manager, block: block)
        
        httpMethod = HTTPMethod.post
        
        url = manager.baseURL + GDWebServiceURLEndPoints.registration
        
        body?["name"] = name
        body?["email"] = email
        body?["password"] = password
        body?["mobile"] = phone
        body?["countrycode"] = countrycode
        body?["type"] = "CUSTOMER"
    }
    
    override func responseSuccess(data: Data?) {
        guard let data = data else {
            return
        }
        var json = [String: Any]()
        do {
            json = (try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any])!
            
        } catch {
            print("Something went wrong")
        }
        print("\(json)")
        
        var loginInfo: GDLogin?
        //if let json = data as? [String: Any]{
        if let info = json["result"] as? [String: Any] {
            let moc = GDStorage.sharedStorage.moc
            moc?.performAndWait {
                loginInfo = GDLogin(dictionary: info, moc: moc)
            }
            GDStorage.sharedStorage.saveMOCToStorage()
        }
        //}
        super.responseSuccess(data: data)
    }
    
}

class GDWSLoginRequest: GDWebServiceRequest {
    
    init(manager : GDWebServiceManager, mobile: String, password: String, block : @escaping GDWSCompletionBlock) {
        
        super.init(manager: manager, block: block)
        
        httpMethod = HTTPMethod.post
        
        url = manager.baseURL + GDWebServiceURLEndPoints.login
        
        body?["mobile"] = mobile
        body?["password"] = password
        
    }
    
    override func responseSuccess(data: Data?) {
        guard let data = data else {
            return
        }
        var json = [String: Any]()
        do {
            json = (try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any])!
            
        } catch {
            print("Something went wrong")
        }
        print("\(json)")
        
        var loginInfo: GDLogin?
        //if let json = data as? [String: Any]{
        if let info = json["result"] as? [String: Any] {
            let moc = GDStorage.sharedStorage.moc
            moc?.performAndWait {
                loginInfo = GDLogin(dictionary: info, moc: moc)
            }
            GDStorage.sharedStorage.saveMOCToStorage()
        }
        //}
        super.responseSuccess(data: data)
    }
}

class GDWSOTPValidationRequest: GDWebServiceRequest {
    init(manager: GDWebServiceManager, otp: String, block: @escaping GDWSCompletionBlock) {
        super.init(manager: manager, block: block)
        httpMethod = HTTPMethod.post
        url = manager.baseURL + GDWebServiceURLEndPoints.otp
        body?["code"] = otp
        body?["uuid"] = GDLogin.loggedInUser()?.uuid
    }
}

class GDWSCountryCodeRequest: GDWebServiceRequest {
    override init(manager: GDWebServiceManager, block: @escaping GDWSCompletionBlock) {
        super.init(manager: manager, block: block)
        httpMethod = HTTPMethod.get
        url = manager.baseURL + GDWebServiceURLEndPoints.listCountries
    }
}

class GDWSUpdateNameRequest: GDWebServiceRequest {
    init(manager: GDWebServiceManager, name: String, block: @escaping GDWSCompletionBlock) {
        super.init(manager: manager, block: block)
        httpMethod = HTTPMethod.put
        url = manager.baseURL + GDWebServiceURLEndPoints.updatename
        headers?["Authorization"] = "\((GDLogin.loggedInUser()?.token)!)"
        body?["name"] = name
    }
}

class GDWSUpdateEmailRequest: GDWebServiceRequest {
    init(manager: GDWebServiceManager, email: String, block: @escaping GDWSCompletionBlock) {
        super.init(manager: manager, block: block)
        httpMethod = HTTPMethod.put
        url = manager.baseURL + GDWebServiceURLEndPoints.updateemail
        headers?["Authorization"] = "\((GDLogin.loggedInUser()?.token)!)"
        body?["email"] = email
    }
}

class GDWSUpdatePasswordRequest: GDWebServiceRequest {
    init(manager: GDWebServiceManager, oldpassword: String, newpassword: String, block: @escaping GDWSCompletionBlock) {
        super.init(manager: manager, block: block)
        httpMethod = HTTPMethod.put
        url = manager.baseURL + GDWebServiceURLEndPoints.updateemail
        headers?["Authorization"] = "\((GDLogin.loggedInUser()?.token)!)"
        body?["oldpassword"] = oldpassword
        body?["password"] = newpassword
    }
}
