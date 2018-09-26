//
//  GDLoginVC.swift
//  Goods
//
//  Created by Nabanita on 07/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import Foundation
import UIKit

class GDSignInVC: GDBaseVC {
    
    @IBOutlet weak var _signInButton: UIButton!
    @IBOutlet weak var _goodsLogo: UIImageView!
    @IBOutlet weak var _mobile: UITextField!
    @IBOutlet weak var _password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColorForTitleViews()
        setFlipViewForLanguage()
        setColorForLabels()
        initializeUI()
        
    }
    
    func initializeUI() {
        _signInButton.layer.cornerRadius = _signInButton.frame.height * 0.5
//        _goodsLogo.image = _goodsLogo.image!.withRenderingMode(.alwaysTemplate)
//        _goodsLogo.tintColor = UIColor.init(red: 255.0/255.0, green: 112.0/255.0, blue: 67.0/255.0, alpha: 1.0)
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
//        let _ = GDLocationManager.sharedManager
//        bringUpDashboard()
//        return
        let _ = GDLocationManager.sharedManager
        if _mobile.text?.count == 0 {
            GDAlertAndLoader.showAlertMessage(GDErrorAlertMessage.emptyMobile)
        }
        else if _password.text?.count == 0 {
            GDAlertAndLoader.showAlertMessage(GDErrorAlertMessage.emptyPassword)
        }
        else {
            login()
        }
        
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "GDRegistrationVC")
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    
    @IBAction func forgotPasswordPressed(_ sender: UIButton) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "GDForgotPasswordVC")
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func login() {
        GDAlertAndLoader.showLoading()
        GDWebServiceManager.sharedManager.loginUser(mobile: _mobile.text!, password: _password.text!, block : {[weak self](response, error) in
            GDAlertAndLoader.hideLoading()
            if let err = error as? NSError {
                if let errorMessage = err.userInfo["message"] as? String {
                    GDAlertAndLoader.showAlertMessage(errorMessage)
                }
            }
            else {
                DispatchQueue.main.async {
                    self?.bringUpDestinationController()
                }
            }
        })
    }
    
    
    func bringUpDestinationController() {
        let destinationType = global.destinationViewType
        switch destinationType {
        case DestinationViewType.dashboard:
            _ = self.navigationController?.popViewController(animated: true)
        case DestinationViewType.mycart:
            bringUpMyCart()
        case DestinationViewType.orders:
            bringOrderHistory()
        case DestinationViewType.myaccount:
            bringUpMyAccount()
        }
    }
    
//    func bringUpDashboard() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "GDTabBarController")
//        self.navigationController?.pushViewController(controller, animated: true)
//    }
    
    func bringUpMyCart() {
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "GDMyCartVC")
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    
    func bringOrderHistory() {
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "GDOrdersHistoryVC")
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    
    func bringUpMyAccount() {
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "GDMyAccountVC")
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
