//
//  GDRegistrationVC.swift
//  Goods
//
//  Created by Tirthankar on 08/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import Foundation
import UIKit

class GDRegistrationVC: GDBaseVC {
    
    @IBOutlet weak var _registrationBtton: UIButton!
    @IBOutlet weak var _name: UITextField!
    @IBOutlet weak var _email: UITextField!
    @IBOutlet weak var _password: UITextField!
    @IBOutlet weak var _confirmPassword: UITextField!
    @IBOutlet weak var _phone: UITextField!
    @IBOutlet weak var _countryCode: UITextField!
    @IBOutlet weak var _userType: UITextField!
    
    private var registrationVM: GDRegistrationVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColorForTitleViews()
        setColorForLabels()
        
        _registrationBtton.layer.cornerRadius = _registrationBtton.frame.height * 0.5
        registrationVM = GDRegistrationVM.init(delegate: self)
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        registrationVM?.onRegistratButtonPressed(name: _name.text!, email: _email.text!, password: _password.text!, phone: _phone.text!, countrycode: _countryCode.text!, usertype: _userType.text!)
    }
}

extension GDRegistrationVC: GDRegistrationVMDelegate {
    
    func invalidInputDetected(_ message: String) {
        GDAlertAndLoader.showAlertMessage(message)
    }
    
    func registraionSucessfull() {
        //Open OTP screen
    }
    
    func registraionError(_ message: String) {
        GDAlertAndLoader.showAlertMessage(message)
    }
}
