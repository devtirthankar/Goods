//
//  GDNearYouViewModel.swift
//  Goods
//
//  Created by nabanita on 03/05/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation

@objc protocol GDNearYouViewModelDelegate {
    func didFetchData()
}

class GDSNearYouViewModel {
    var delegate: GDNearYouViewModelDelegate?
    var stores = [Store]()
    var topStores = [Store]()
    
    //MARK: Fetch Data
    func fetchStores(latitude: Double, longitude: Double) {
        GDAlertAndLoader.showLoading()
        GDWebServiceManager.sharedManager.getStoresNearYou(latitude: latitude, longitude: longitude, block: {[weak self](response, error) in
            GDAlertAndLoader.hideLoading()
            DispatchQueue.main.async {
                guard let data = response as? Data else {
                    print("No product data")
                    return
                }
                
                guard let storelist = try? JSONDecoder().decode(Stores.self, from: data) else {
                    print("Error: Couldn't decode data into Stores")
                    return
                }
                for item in storelist.result {
                    self?.stores.append(item)
                }
                self?.delegate?.didFetchData()
            }
        })
    }
    
    //Write service for top stores
    func fetchTopStores(latitude: Double, longitude: Double) {
        GDAlertAndLoader.showLoading()
        GDWebServiceManager.sharedManager.getStoresNearYou(latitude: latitude, longitude: longitude, block: {[weak self](response, error) in
            GDAlertAndLoader.hideLoading()
            DispatchQueue.main.async {
                guard let data = response as? Data else {
                    print("No product data")
                    return
                }
                
                guard let storelist = try? JSONDecoder().decode(Stores.self, from: data) else {
                    print("Error: Couldn't decode data into Stores")
                    return
                }
                for item in storelist.result {
                    self?.topStores.append(item)
                }
                self?.delegate?.didFetchData()
            }
        })
    }
}
