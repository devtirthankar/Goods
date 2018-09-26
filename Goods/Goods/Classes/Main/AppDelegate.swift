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
import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyCWRKgXnnalWlhEcSA81S_wEAc0D9AQqCA")//("AIzaSyAixZt2Gq4ogzgIw5LEKIdhQgCc1wRxRMM")
        GMSPlacesClient.provideAPIKey("AIzaSyCWRKgXnnalWlhEcSA81S_wEAc0D9AQqCA")//("AIzaSyAixZt2Gq4ogzgIw5LEKIdhQgCc1wRxRMM")
        IQKeyboardManager.sharedManager().enable = true
        GDStorage.sharedStorage.startCoreDataStack()
        
        if let setLanguage = UserDefaults.standard.value(forKey: "AppleLanguages") {
            print("LANGUAGE SET IS : \(setLanguage)")
            UserDefaults.standard.set("ar", forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            print("Now it's: \(UserDefaults.standard.value(forKey: "AppleLanguages"))")
        }
        
        /*
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound],
                                           categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        FirebaseApp.configure()
        Messaging.messaging().remoteMessageDelegate = self
        
        UIApplication.shared.applicationIconBadgeNumber = 0;
        
        // Add observer for InstanceID token refresh callback.
        NotificationCenter.default.addObserver(self, selector: #selector(self.tokenRefreshNotification), name: NSNotification.Name.firInstanceIDTokenRefresh, object: nil)
        
        */
        return true
    }
}

