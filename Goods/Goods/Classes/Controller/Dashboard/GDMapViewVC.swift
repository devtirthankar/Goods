//
//  GDMapViewVC.swift
//  Goods
//
//  Created by Tirthankar on 08/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit
import GoogleMaps

class GDMapViewVC: GDBaseVC {
    
    @IBOutlet weak var _mapView: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setColorForTitleViews()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Dispose of any resources that can be recreated.
        recenterMap()
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton){
        let tabBar = self.tabBarController as! GDTabBarController
        tabBar.openDrawer()
    }
    
    func recenterMap() {
        
        var latitude = 0.0
        var longitude = 0.0
        
        if let userlocation = GDLocationManager.sharedManager.userLocation {
            latitude = userlocation.coordinate.latitude
            longitude = userlocation.coordinate.longitude
            placeMarkerOnMap(latitude: latitude, longitude: longitude)
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 15.5)
        _mapView.animate(to: camera)
    }
    
    func placeMarkerOnMap(latitude: Double, longitude: Double) {
        
        let markerView = UINib(nibName: "GDMarkerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! GDMarkerView
        markerView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        markerView.markerImage.image = markerView.markerImage.image!.withRenderingMode(.alwaysTemplate)
        markerView.markerImage.tintColor = UIColor.colorForHex(GDColor.ThemeColor as NSString)
        
        let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let marker = GMSMarker(position: position)
        marker.iconView = markerView
        marker.title = "Shop name"
        marker.tracksViewChanges = true
        marker.map = _mapView
    }
    

}
