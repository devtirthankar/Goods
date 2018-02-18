//
//  UIColor+Additions.swift
//  Wagr
//
//  Created by Nabanita on 30/08/17.
//  Copyright © 2017 company. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    /*
    convenience init(hex:Int, alpha:CGFloat = 1.0) {
        self.init(
            red:   CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8)  / 255.0,
            blue:  CGFloat((hex & 0x0000FF) >> 0)  / 255.0,
            alpha: alpha
        )
    }
 */
    
    public class func colorForHex(_ hexColor : NSString) -> UIColor{
        
        return UIColor.colorForHex(hexColor, opacity: 1)
        
    }

    public class func colorForHex(_ hex : NSString, opacity: Float) -> UIColor{
        
        var hexColor = hex
        hexColor = hexColor.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased() as NSString
        
        // String should be 6 or 7 characters if it includes '#'
        if hexColor.length<6{
            return UIColor.black
        }
        
        // strip # if it appears
        if hexColor.hasPrefix("#"){
            hexColor = hexColor.substring(from: 1) as NSString
        }
        
        // if the value isn't 6 characters at this point return
        // the color black
        
        if (hexColor.length != 6){
            return UIColor.black
        }
        
        // Separate into r, g, b substrings
        
        var range : NSRange = NSRange(location: 0, length: 2)
        
        let rString = hexColor.substring(with: range)
        
        range.location = 2;
        
        let gString = hexColor.substring(with: range)
        
        range.location = 4;
        
        let bString = hexColor.substring(with: range)
        
        // Scan values
        
        var r : CUnsignedInt = 0
        var g : CUnsignedInt = 0
        var b : CUnsignedInt = 0
        
        
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(Float(r) / Float(255.0)), green: CGFloat(Float(g) / Float(255.0)), blue: CGFloat(Float(b) / Float(255.0)), alpha: CGFloat(opacity))
        
        
    }

}
