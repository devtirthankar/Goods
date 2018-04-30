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
        
        _ = Alamofire.SessionManager(configuration: configuration)
        url = url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        url = url?.replacingOccurrences(of: "+", with: "%2B")
        
        if httpMethod == HTTPMethod.post || httpMethod == HTTPMethod.put {
            self.request = Alamofire.request(url!, method: httpMethod, parameters: body, encoding: URLEncoding.default, headers: headers).validate(statusCode: 200...300)
        }else{
            self.request = Alamofire.request(url!, method: httpMethod, parameters: body, encoding: URLEncoding.httpBody, headers: headers).validate(statusCode: 200...300)
        }
        
        self.request?.responseJSON(queue: concurrentQueue, options: JSONSerialization.ReadingOptions.allowFragments, completionHandler: { (response : DataResponse) in
            
            if let error = response.result.error{
                self.responseFailed(data: response.data, responseError: error)
                return
            }
            let attributeDict = response.result.value
            if let responseDictionary = attributeDict as? [String: Any] {
                print(responseDictionary)
            }
            self.responseSuccess(data: attributeDict)
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
    
    func responseSuccess(data : Any?){
        
        GDWebServiceManager.sharedManager.closeService(service: self)
        
        DispatchQueue.main.async {
            self.block(data,nil)
        }
        
    }
    
    func responseFailed(data : Data?, responseError : Error?){
        
        print("\(self) error = \(String(describing: responseError))")
        
        var errorcode = (responseError as! NSError).code
        let aferror = responseError as? AFError
        if let aferror = aferror{
            if let responseCode = aferror.responseCode{
                errorcode = responseCode
            }
        }
        
        var error = data?.validateError(errorcode: (responseError as! NSError).code)
        if error == nil{
            error = responseError as? NSError
        }
        
        DispatchQueue.main.async {
            self.block(nil,error)
        }
        GDWebServiceManager.sharedManager.closeService(service: self)
    }
    
}

extension Data{
    
    func validateError(errorcode : Int) -> NSError?{
        
        var json : [String : Any]?
        do{
            json = try JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.allowFragments) as? [String : Any]
            let errors = json?["errors"] as? [[String : Any]]
            if let errors = errors{
                for item in errors {
                    if item["code"] != nil{
                        let message = item["message"] as! String
                        let error = NSError(domain: "", code: errorcode, userInfo: ["message" : message])
                        return error
                    }
                }
            }
        }
        catch{
            return nil
        }
        
        return nil
        
    }
}
