//
//  AppDelegate.swift
//  Goods
//
//  Created by Nabanita on 07/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyAixZt2Gq4ogzgIw5LEKIdhQgCc1wRxRMM")
        GMSPlacesClient.provideAPIKey("AIzaSyAixZt2Gq4ogzgIw5LEKIdhQgCc1wRxRMM")
        GDStorage.sharedStorage.startCoreDataStack()
        return true
    }
}

