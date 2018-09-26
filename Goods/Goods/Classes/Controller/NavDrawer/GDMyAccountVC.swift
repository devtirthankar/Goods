//
//  GDMyAccountVC.swift
//  Goods
//
//  Created by Nabanita on 11/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit

class GDMyAccountVC: GDBaseVC {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    var initialNameValue = ""
    var initialEmailValue = ""
    var isEditButtonEnable = false
    var userProfile: GDUserProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColorForTitleViews()
        setFlipViewForLanguage()
        // Do any additional setup after loading the view.
        initializeUI()
        getInitialInputFieldValues()
    }
    
    func initializeUI() {
        changePasswordButton.layer.cornerRadius = changePasswordButton.frame.height * 0.5
        editButton.layer.cornerRadius = editButton.frame.height * 0.5
        editButton.layer.borderColor = UIColor.colorForHex(GDColor.ThemeColor as NSString).cgColor
        editButton.layer.borderWidth = 1.0
        editButton.alpha = 0.5
        editButton.isUserInteractionEnabled = false
        userProfile = GDUserProfile.loggedInUser()
        name.text = GDUserProfile.loggedInUser()?.name?.capitalized
        if let emailId = GDUserProfile.loggedInUser()?.email {
            email.text = emailId
        }
        phone.text = GDUserProfile.loggedInUser()?.mobile
    }
    
    func getInitialInputFieldValues() {
        if let _ = name.text {
            initialNameValue = name.text!
        }
        if let _ = email.text {
            initialEmailValue = email.text!
        }
    }

    @IBAction func backButtonPressed(_ sender: UIButton){
        if global.destinationViewType == DestinationViewType.myaccount {
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for aViewController in viewControllers {
                if(aViewController is GDNearYouVC || aViewController is GDSearchVC || aViewController is GDMapViewVC){
                    global.destinationViewType = DestinationViewType.dashboard
                    self.navigationController!.popToViewController(aViewController, animated: true)
                    return
                }
            }
        }else {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton){
        if isEditButtonEnable == true {
            if name.text?.elementsEqual(initialNameValue) != true {
                updateName()
            }
            if email.text?.elementsEqual(initialEmailValue) != true {
                updateEmail()
            }
        }
    }
    
    func updateName() {
        GDAlertAndLoader.showLoading()
        GDWebServiceManager.sharedManager.updateName(name: name.text!, block: {[weak self](response, error) in
            GDAlertAndLoader.hideLoading()
            if let err = error as NSError? {
                if let errorMessage = err.userInfo["message"] as? String {
                    GDAlertAndLoader.showAlertMessage(errorMessage)
                }
            }
            else {
                self?.userProfile?.name = self?.name.text
                DispatchQueue.main.async {
                    GDAlertAndLoader.showAlertMessage(GDMessage.updationSuccess)
                    self?.isEditButtonEnable = false
                }
            }
        })
    }
    
    func updateEmail() {
        GDAlertAndLoader.showLoading()
        GDWebServiceManager.sharedManager.updateEmail(email: email.text!, block: {[weak self](response, error) in
            GDAlertAndLoader.hideLoading()
            if let err = error as NSError? {
                if let errorMessage = err.userInfo["message"] as? String {
                    GDAlertAndLoader.showAlertMessage(errorMessage)
                }
            }
            else {
                self?.userProfile?.email = self?.email.text
                DispatchQueue.main.async {
                    GDAlertAndLoader.showAlertMessage(GDMessage.updationSuccess)
                    self?.isEditButtonEnable = false
                }
            }
        })
    }
    
    @IBAction func changePasswordPressed(_ sender: UIButton){
        let controler = self.storyboard?.instantiateViewController(withIdentifier: "GDEditAccountDetailsVC") as! GDEditAccountDetailsVC
        self.navigationController?.pushViewController(controler, animated: true)
    }

}

extension GDMyAccountVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Changed")
        checkIfFieldsEdited()
    }
    
    func checkIfFieldsEdited() {
        if (name.text?.elementsEqual(initialNameValue) != true || email.text?.elementsEqual(initialNameValue) != true) {
            isEditButtonEnable = true
            editButton.isUserInteractionEnabled = true
            editButton.alpha = 1.0
        }
    }
}
