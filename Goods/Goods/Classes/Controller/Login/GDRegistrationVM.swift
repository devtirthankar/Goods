//
//  GDRegistrationVM.swift
//  Goods
//
//  Created by nabanita on 25/02/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

protocol GDRegistrationVMDelegate {
    func registraionSucessfull()
    func registraionError(_ message: String)
    func invalidInputDetected(_ message: String)
}

class GDRegistrationVM: NSObject {
    
    private var delegate: GDRegistrationVMDelegate?
    
    init(delegate: GDRegistrationVMDelegate) {
        self.delegate = delegate
    }
    
    func onRegistratButtonPressed(name : String, email: String, password: String, phone: String, countrycode: String, usertype:String) {
        
        var message: String = ""
        if name.count == 0 {
            message = GDErrorAlertMessage.emptyName
        }
        else if email.count == 0 {
            message = GDErrorAlertMessage.emptyEmail
        }
        else if GDUtilities.checkEmailValidity(email) != true {
            message = GDErrorAlertMessage.invalidEmail
        }
        else if password.count == 0 {
            message = GDErrorAlertMessage.emptyPassword
        }
        else if phone.count == 0 {
            message = GDErrorAlertMessage.emptyMobile
        }
        else if countrycode.count == 0 {
            message = GDErrorAlertMessage.emptyCountryCode
        }
            
        if message.count == 0 {
            self.delegate?.invalidInputDetected(message)
        }
        else {
            //if validation successfull, call register api
            registerUser(name: name, email: email, password: password, phone: phone, countrycode: countrycode, usertype: usertype)
        }
    }
    
    private func registerUser(name : String, email: String, password: String, phone: String, countrycode: String, usertype:String) {
        GDWebServiceManager.sharedManager.registerUser(name: name, email: email, password: password, phone: phone, countrycode: countrycode, usertype: usertype, block: {[weak self](response, error) in
            if let err = error {
                self?.delegate?.registraionError(err.localizedDescription)
            }
            else {
                self?.delegate?.registraionSucessfull()
            }
        })
    }
}
