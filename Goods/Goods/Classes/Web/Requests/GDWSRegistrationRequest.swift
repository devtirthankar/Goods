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
    
    init(manager : GDWebServiceManager, firstname : String, lastname: String, email: String, password: String, phone: String, block : @escaping GDWSCompletionBlock) {
        
        super.init(manager: manager, block: block)
        
        httpMethod = HTTPMethod.post
        
        url = manager.baseURL + GDWebServiceURLEndPoints.registration
        
        body?["fname"] = firstname
        body?["lname"] = lastname
        body?["email"] = email
        body?["password"] = password
        body?["phone"] = phone
        
    }
    
}

class GDWSLoginRequest: GDWebServiceRequest {
    
    init(manager : GDWebServiceManager, email: String, password: String, block : @escaping GDWSCompletionBlock) {
        
        super.init(manager: manager, block: block)
        
        httpMethod = HTTPMethod.post
        
        url = manager.baseURL + GDWebServiceURLEndPoints.login
        
        body?["email"] = email
        body?["password"] = password
        
    }
}
