//
//  GDMyAccountVC.swift
//  Goods
//
//  Created by Nabanita on 11/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit

class GDMyAccountVC: GDBaseVC {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setColorForTitleViews()

        // Do any additional setup after loading the view.
        print("\(String(describing: GDUserProfile.loggedInUser()?.name))\n\(String(describing: GDUserProfile.loggedInUser()?.email))\n\(String(describing: GDUserProfile.loggedInUser()?.mobile))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backButtonPressed(_ sender: UIButton){
        let _ = self.navigationController?.popViewController(animated: true)
    }

}
