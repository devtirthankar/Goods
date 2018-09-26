//
//  GDForgotPasswordVC.swift
//  Goods
//
//  Created by Tirthankar M on 29/07/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

class GDForgotPasswordVC: GDBaseVC, GDDropDownViewDelegate {
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet weak var _phone: UITextField!
    @IBOutlet weak var _countryCode: UITextField!
    var _categoryView : GDDropDownView!
    var _transparentView : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setColorForTitleViews()
        setFlipViewForLanguage()
        // Do any additional setup after loading the view.
        saveButton.layer.cornerRadius = saveButton.frame.height * 0.5
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func countryCodeButtonPressed(_ sender: UIButton) {
        
        _transparentView = UIView();
        _transparentView.backgroundColor = UIColor.black;
        _transparentView.alpha = 0.6
        _transparentView.frame = self.view.frame
        
        self.view.addSubview(_transparentView)
        
        _categoryView = UINib(nibName: "GDDropDownView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! GDDropDownView
        _categoryView.delegate = self
        
        _categoryView.bounds.size.width = self.view.bounds.size.width
        _categoryView.bounds.size.height = 287
        _categoryView.frame.origin = CGPoint.init(x: 0, y: self.view.bounds.size.height - 287)
        _categoryView._headerTitle.text = GDMessage.selectCountry
        _categoryView.pickerDataSource = ["SA +966"]
        
        self.view.addSubview(_categoryView)
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        var message: String = ""
        if _countryCode.text?.count == 0 {
            message = GDErrorAlertMessage.emptyName
        }
        else if _phone.text?.count == 0 {
            message = GDErrorAlertMessage.emptyMobile
        }
        if message.count > 0 {
            GDAlertAndLoader.showAlertMessage(message)
        }
        else {
            requestToResendPassword(countrycode: _countryCode.text!, phone: _phone.text!)
        }
    }
    
    func requestToResendPassword(countrycode: String, phone: String) {
        GDAlertAndLoader.showLoading()
        GDWebServiceManager.sharedManager.resetPassword(block: {[weak self](response, error) in
            GDAlertAndLoader.hideLoading()
            if let err = error {
                GDAlertAndLoader.showAlertMessage(err.localizedDescription)
            }
            else {
                GDAlertAndLoader.showAlertMessage(GDMessage.passwordWillBeSent)
            }
        })
    }
    
    //MARK: GODropDownViewDelegate
    func donePressed(selectedValue: String, pickerHeader: String) {
        if _transparentView != nil {
            _transparentView.removeFromSuperview()
            _transparentView = nil
        }
        if _categoryView  != nil {
            _categoryView.removeFromSuperview()
            _categoryView = nil
        }
        _countryCode.text = selectedValue
    }
}
