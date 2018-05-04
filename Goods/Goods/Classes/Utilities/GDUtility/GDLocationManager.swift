//
//  GDLocationManager.swift
//  Wagr
//
//  Created by Nabanita on 01/10/17.
//  Copyright © 2017 company. All rights reserved.
//

import Foundation
import CoreLocation

class GDLocationManager: NSObject, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager!
    var userLocation : CLLocation?
    
    
    static let sharedManager : GDLocationManager = {
        let instance = GDLocationManager()
        return instance
    }()
    
    override init(){
        super.init()
        
        registerLocationServices()
        
    }
    
    func registerLocationServices(){
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
            //locationManager.startMonitoringSignificantLocationChanges()
            locationManager.startUpdatingLocation()
        }

    }

    func startLocationServices(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        self.userLocation = userLocation
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: GDNotifications.userLocationUpdated), object: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
}
