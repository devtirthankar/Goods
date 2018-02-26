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
    @IBOutlet weak var _email: UITextField!
    @IBOutlet weak var _password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColorForTitleViews()
        setColorForLabels()
        initializeUI()
    }
    
    func initializeUI() {
        
        _signInButton.layer.cornerRadius = _signInButton.frame.height * 0.5
        //_goodsLogo.image = myImageView.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        _goodsLogo.image = _goodsLogo.image!.withRenderingMode(.alwaysTemplate)
        _goodsLogo.tintColor = UIColor.init(red: 255.0/255.0, green: 112.0/255.0, blue: 67.0/255.0, alpha: 1.0)//UIColor.colorForHex(GDColor.ThemeColor as NSString)//UIColor.init(red: 41.0/255.0, green: 190.0/255.0, blue: 136.0/255.0, alpha: 1.0)
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        
        GDLocationManager.sharedManager
        
        if _email.text?.count == 0 {
            
        }
        else if GDUtilities.checkEmailValidity(_email.text!) == false {
            
        }
        else if _password.text?.count == 0 {
            
        }
        else {
            validateLogin()
        }
        
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "GDRegistrationVC")
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    
    func validateLogin() {
        GDWebServiceManager.sharedManager.loginUser(email: _email.text!, password: _password.text!, block : {[weak self](response, error) in
            
            if let error = error {
                print("Login error")
            }
            else {
                print("Login successful")
                DispatchQueue.main.async {
                    self?.bringUpDashboard()
                }
            }
        })
    }
    
    func bringUpDashboard() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GDTabBarController")
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
