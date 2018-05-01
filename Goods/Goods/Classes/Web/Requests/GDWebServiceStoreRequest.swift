//
//  GDWebServiceStoreRequest.swift
//  Goods
//
//  Created by nabanita on 01/05/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation
import Alamofire

class GDWebServiceStoreRequest: GDWebServiceRequest {
    override init(manager : GDWebServiceManager, block : @escaping GDWSCompletionBlock) {
        super.init(manager: manager, block: block)
        httpMethod = HTTPMethod.get
        url = manager.baseURL + GDWebServiceURLEndPoints.stores
        headers?["Authorization"] = "\((GDLogin.loggedInUser()?.token)!)"
    }
    
    override func responseSuccess(data: Any?) {
        GDStorage.sharedStorage.deleteEntityFromDBEntityName("GDStore")
        var stores = [GDStore]()
        if let json = data as? [String: Any]{
            if let list = json["result"] as? [[String: Any]]{
                let moc = GDStorage.sharedStorage.moc
                moc?.performAndWait {
                    for info in list {
                        let store = GDStore.init(dictionary: info, moc: moc)
                        stores.append(store)
                    }
                }
            }
            GDStorage.sharedStorage.saveMOCToStorage()
        }
        super.responseSuccess(data: stores)
    }
}
