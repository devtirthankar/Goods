//
//  GDOTPVC.swift
//  Goods
//
//  Created by nabanita on 30/04/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

class GDOTPVC: GDBaseVC {
    
    @IBOutlet weak var _submitButton: UIButton!
    @IBOutlet weak var _otp: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeUI()
    }
    
    func initializeUI() {
        _submitButton.layer.cornerRadius = _submitButton.frame.height * 0.5
        _submitButton.layer.borderColor = UIColor.colorForHex(GDColor.ThemeColor as NSString).cgColor
        _submitButton.layer.borderWidth = 1.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        if _otp.text?.count == 0 {
            GDAlertAndLoader.showAlertMessage("Please enter OTP.")
        }
        else {
            GDWebServiceManager.sharedManager.validateOTP(otp: _otp.text!, block : {[weak self](response, error) in
                if let err = error as NSError? {
                    if let errorMessage = err.userInfo["message"] as? String {
                        GDAlertAndLoader.showAlertMessage(errorMessage)
                    }
                }
                else {
                    DispatchQueue.main.async {
                        //self?.bringUpDashboard()
                        GDAlertAndLoader.showAlertMessage(GDMessage.registrationSuccess)
                        self?.navigationController?.popToRootViewController(animated: true)
                    }
                }
            })
        }
    }
    
    func bringUpDashboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GDTabBarController")
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
