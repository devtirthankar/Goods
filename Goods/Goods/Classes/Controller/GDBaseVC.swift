//
//  GDBaseVC.swift
//  Goods
//
//  Created by Nabanita on 31/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit

class GDBaseVC: UIViewController {
    
    @IBOutlet var _themeView : [AnyObject]?
    @IBOutlet var _themeLabel : [UILabel]?
    func setColorForTitleViews(){
        
        guard let themeViews = _themeView else{
            return
        }
        
        for themeView in themeViews{
            
            let view = themeView as! UIView
            view.backgroundColor = UIColor.colorForHex(GDColor.ThemeColor as NSString)
            
            
        }
    }
    
    func setColorForLabels(){
        
        guard let themeLabels = _themeLabel else{
            return
        }
        
        for themeLabel in themeLabels{
            
            themeLabel.textColor = UIColor.colorForHex(GDColor.ThemeColor as NSString)
            
        }
    }

}
