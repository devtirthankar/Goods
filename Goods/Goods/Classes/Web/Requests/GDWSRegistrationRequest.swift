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
    
    init(manager : GDWebServiceManager, name : String, email: String, password: String, phone: String, countrycode: String, usertype:String, block : @escaping GDWSCompletionBlock) {
        
        super.init(manager: manager, block: block)
        
        httpMethod = HTTPMethod.post
        
        url = manager.baseURL + GDWebServiceURLEndPoints.registration
        
        body?["name"] = name
        body?["email"] = email
        body?["password"] = password
        body?["mobile"] = phone
        body?["countrycode"] = countrycode
        body?["type"] = usertype
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
}

class GDOTPValidationRequest: GDWebServiceRequest {
    
    init(manager: GDWebServiceManager, otp: String, block: @escaping GDWSCompletionBlock) {
        super.init(manager: manager, block: block)
        
        httpMethod = HTTPMethod.post
        
        url = manager.baseURL + GDWebServiceURLEndPoints.login
        
        body?["code"] = otp
        body?["uuid"] = ""
    }
    
}
