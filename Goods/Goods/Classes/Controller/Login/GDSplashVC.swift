//
//  ViewController.swift
//  Goods
//
//  Created by Nabanita on 07/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit

class GDSplashVC: GDBaseVC {
    
    @IBOutlet weak var _goodsLogo: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setColorForTitleViews()
        _goodsLogo.image = _goodsLogo.image!.withRenderingMode(.alwaysTemplate)
        _goodsLogo.tintColor = UIColor.colorForHex(GDColor.ThemeColor as NSString)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.bringUpDashboard()
//            if let _ = GDLogin.loggedInUser()?.token {
//                self.bringUpDashboard()
//            }else {
//                self.bringUpLoginView()
//            }
        }
    }
    
    /*
    func bringUpLoginView() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GDSignInVC")
        self.navigationController?.pushViewController(controller, animated: false)
    }*/
    
    func bringUpDashboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GDTabBarController")
        self.navigationController?.pushViewController(controller, animated: true)
    }

}

