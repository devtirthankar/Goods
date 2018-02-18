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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColorForTitleViews()
        setColorForLabels()
        
        _registrationBtton.layer.cornerRadius = _registrationBtton.frame.height * 0.5
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
