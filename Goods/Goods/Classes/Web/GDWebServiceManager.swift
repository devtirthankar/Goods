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
    static let registration = ""
    static let login = ""
}

enum GDServerURL: String {
    case development = "development"
    case test = "test"
    case production = "production"
    case staging = "staging"
}

class GDWebServiceManager: NSObject {
    var serviceArray = [GDWebServiceRequest]()
    var baseURL = GDServerURL.staging.rawValue
    
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
