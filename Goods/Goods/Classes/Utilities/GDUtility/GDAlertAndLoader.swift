//
//  GDLoader.swift
//  Goods
//
//  Created by nabanita on 30/04/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation
import UIKit

class GDAlertAndLoader{
    class func showAlertMessage(_ message : String){
        let title = NSLocalizedString("Goods", comment: "")
        let messageText = NSLocalizedString(message, comment: "")
        let buttonTitle = NSLocalizedString("Ok", comment: "")
        let alert = UIAlertController(title: title, message: messageText, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default, handler: nil))
        let app = UIApplication.shared.delegate as? AppDelegate
        let controller = app?.window?.rootViewController
        
        controller?.present(alert, animated: true, completion: nil)
    }
}
