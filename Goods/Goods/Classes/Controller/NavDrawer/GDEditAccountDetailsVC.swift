//
//  GDEditAccountDetailsVC.swift
//  Goods
//
//  Created by nabanita on 22/05/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

class GDEditAccountDetailsVC: GDBaseVC {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var headerText: UILabel!
    @IBOutlet weak var oldpassword: UITextField!
    @IBOutlet weak var newpassword: UITextField!
    @IBOutlet weak var confirmpassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
    }
    
    func initializeUI() {
        saveButton.layer.cornerRadius = saveButton.frame.height * 0.5
        saveButton.layer.borderColor = UIColor.colorForHex(GDColor.ThemeColor as NSString).cgColor
        saveButton.layer.borderWidth = 1.0
    }

    @IBAction func backButtonPressed(_ sender: UIButton){
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton){
        var message: String = ""
        if oldpassword.text!.count == 0 {
            message = GDErrorAlertMessage.emptyOldPassword
            GDAlertAndLoader.showAlertMessage(message)
        }
        else if newpassword.text!.count == 0 {
            message = GDErrorAlertMessage.emptyNewPassword
            GDAlertAndLoader.showAlertMessage(message)
        }
        else if confirmpassword.text!.count == 0 {
            message = GDErrorAlertMessage.emptyConfirmPassword
            GDAlertAndLoader.showAlertMessage(message)
        }
        else if confirmpassword.text!.elementsEqual(newpassword.text!) != true {
            message = GDErrorAlertMessage.mismatchPassword
            GDAlertAndLoader.showAlertMessage(message)
        }
        else {
            updatePassword()
        }
    }
    
    func updatePassword() {
        GDAlertAndLoader.showLoading()
        GDWebServiceManager.sharedManager.updatePassword(oldpassword: oldpassword.text!, newpassword: newpassword.text!, block: {[weak self](response, error) in
            GDAlertAndLoader.hideLoading()
            if let err = error as NSError? {
                if let errorMessage = err.userInfo["message"] as? String {
                    GDAlertAndLoader.showAlertMessage(errorMessage)
                }
            }
            else {
                DispatchQueue.main.async {
                    GDAlertAndLoader.showAlertMessage(GDMessage.updationSuccess)
                }
            }
        })
    }
}
