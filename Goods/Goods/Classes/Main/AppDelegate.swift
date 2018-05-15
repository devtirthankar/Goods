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
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyDHrLeBHF5M5Y0EHAG0Ewk8FAYCE0ascEI")
        GMSPlacesClient.provideAPIKey("AIzaSyDHrLeBHF5M5Y0EHAG0Ewk8FAYCE0ascEI")
        IQKeyboardManager.sharedManager().enable = true
        GDStorage.sharedStorage.startCoreDataStack()
        return true
    }
}

