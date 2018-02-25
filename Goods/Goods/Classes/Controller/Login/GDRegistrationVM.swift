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
    func registraionError()
    func invalidInputDetected(_ message: String)
    func emptyInputFieldDetected(_ message: String)
}

class GDRegistrationVM: NSObject {
    
    private var delegate: GDRegistrationVMDelegate?
    
    init(delegate: GDRegistrationVMDelegate) {
        self.delegate = delegate
    }
    
    func onRegistratButtonPressed(firstName: String, lastName: String, email: String, password: String, phone: String) {
        
        //Check for input validation
        
        //if validation successfull, call register api
        registerUser(firstName: firstName, lastName: lastName, email: email, password: password, phone: phone)
    }
    
    private func registerUser(firstName: String, lastName: String, email: String, password: String, phone: String) {
        GDWebServiceManager.sharedManager.registerUser(firstname: firstName, lastname: lastName, email: email, password: password, phone: phone, block: {[weak self](response, error) in
            if let error = error {
                self?.delegate?.registraionError()
            }
            else {
                self?.delegate?.registraionSucessfull()
            }
        })
    }
}
