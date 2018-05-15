//
//  GDMapViewVC.swift
//  Goods
//
//  Created by Tirthankar on 08/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit
import GoogleMaps

class GDMapViewVC: GDBaseVC, GMSMapViewDelegate {
    
    @IBOutlet weak var _mapView: GMSMapView!
    var stores = [Store]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setColorForTitleViews()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Dispose of any resources that can be recreated.
        _mapView.delegate = self
        fetchStores()
        recenterMap()
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton){
        let tabBar = self.tabBarController as! GDTabBarController
        tabBar.openDrawer()
    }
    
    func recenterMap() {
        
        var latitude = 21.510472500000017
        var longitude = 39.16535546874998
        
        if let userlocation = GDLocationManager.sharedManager.userLocation {
            latitude = userlocation.coordinate.latitude
            longitude = userlocation.coordinate.longitude
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 15.5)
        _mapView.animate(to: camera)
    }
    
    func placeMarkerOnMap() {
        
        for store in stores {
            let str = store as Store
            if let addresses = str.addresses {
                for address in addresses {
                    let lat = address.lat
                    let lng = address.lng
                    let markerView = UINib(nibName: "GDMarkerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! GDMarkerView
                    markerView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                    
                    markerView.markerImage.image = markerView.markerImage.image!.withRenderingMode(.alwaysTemplate)
                    markerView.markerImage.tintColor = UIColor.colorForHex(GDColor.ThemeColor as NSString)
                    
                    let position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                    
                    let marker = GMSMarker(position: position)
                    marker.iconView = markerView
                    marker.title = str.storename
                    marker.tracksViewChanges = true
                    marker.map = _mapView
                }
            }
        }
        
        
    }
    
    //MARK: Fetch Data
    func fetchStores() {
        GDWebServiceManager.sharedManager.getStores(block: {[weak self](response, error) in
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
                self?.placeMarkerOnMap()
            }
        })
    }
}
