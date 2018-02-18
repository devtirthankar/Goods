//
//  ViewController.swift
//  Goods
//
//  Created by Nabanita on 07/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit

class GDSplashVC: GDBaseVC {
    
    @IBOutlet weak var _goodsLogo: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setColorForTitleViews()
        
        _goodsLogo.image = _goodsLogo.image!.withRenderingMode(.alwaysTemplate)
        _goodsLogo.tintColor = UIColor.colorForHex(GDColor.ThemeColor as NSString)//init(red: 41.0/255.0, green: 190.0/255.0, blue: 136.0/255.0, alpha: 1.0)
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.bringUpLoginView()
        }
    }
    
    func bringUpLoginView() {
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GDSignInVC")
        self.navigationController?.pushViewController(controller, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

