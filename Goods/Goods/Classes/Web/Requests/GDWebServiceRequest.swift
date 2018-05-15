//
//  GDWebServiceRequest.swift
//  Goods
//
//  Created by nabanita on 25/02/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit
import Alamofire

class GDWebServiceRequest: NSObject {
    
    var block : GDWSCompletionBlock
    
    var url : String?
    
    var httpMethod : HTTPMethod = .get
    
    var headers : HTTPHeaders? = [String : String]()
    
    var body : Parameters? = Parameters()
    
    var request : DataRequest?
    
    weak var manager : GDWebServiceManager?
    
    let concurrentQueue = DispatchQueue(label: "userqueue", attributes: .concurrent)
    
    init(manager : GDWebServiceManager, block : @escaping GDWSCompletionBlock) {
        self.block = block
        self.manager = manager
    }
    
    func start(){
        
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = nil
        headers?["Content-Type"] = "application/json"
        _ = Alamofire.SessionManager(configuration: configuration)
        url = url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        url = url?.replacingOccurrences(of: "+", with: "%2B")
        
        if httpMethod == HTTPMethod.post || httpMethod == HTTPMethod.put || httpMethod == HTTPMethod.delete {
            self.request = Alamofire.request(url!, method: httpMethod, parameters: body, encoding: JSONEncoding(), headers: headers).validate(statusCode: 200...300)
        }else{
            self.request = Alamofire.request(url!, method: httpMethod, parameters: body, encoding: URLEncoding.httpBody, headers: headers).validate(statusCode: 200...300)
        }
        
        self.request?.responseJSON(queue: concurrentQueue, options: JSONSerialization.ReadingOptions.allowFragments, completionHandler: { (response : DataResponse) in
            let attributeDict = response.result.value
            if let responseDictionary = attributeDict as? [String: Any] {
                if let statusDictionary = responseDictionary["status"] as? [String: Any] {
                    if let code = statusDictionary["code"] as? Int {
                        if code == 200 {
                            //self.responseSuccess(data: attributeDict as? Data)
                            self.responseSuccess(data: response.data)
                        }else{
                            self.responseFailed(statusDictionary: statusDictionary, responseError: response.result.error)
                        }
                    }
                }
            }
 
        })
        
    }
    
    func stop(){
        
        if let request = self.request{
            request.cancel()
            
        }
        
    }

    deinit {
        self.url = nil
        self.body = nil
        self.request = nil
        self.headers = nil
        print("\(self) deinit")
    }
    
}

extension GDWebServiceRequest{
    
    func responseSuccess(data : Data?){
        
        //GDWebServiceManager.sharedManager.closeService(service: self)
        
        DispatchQueue.main.async {
            self.block(data,nil)
        }
        
    }
    
    func responseFailed(statusDictionary : [String: Any], responseError : Error?) {
        
        var message = "Could not fetch data"
        if let msg = statusDictionary["description"] as? String {
            message = msg
        }
        let error = NSError(domain: "", code: 400, userInfo: ["message" : message])
        DispatchQueue.main.async {
            self.block(nil,error)
        }
    }
    
}
