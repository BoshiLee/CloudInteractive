//
//  UIColorHelper.swift
//  Bump
//
//  Created by Boshi Li on 18/05/2017.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import UIKit

extension UIColor{
    static var bumpRed: UIColor {
        return rawValueRGB(rawRed: 255, rawGreen: 56, rawBlue: 56, alpha: 1)
    }
    static var bumpYellow: UIColor {
        return UIColor(red: 248.0/255.0, green: 233.0/255.0, blue: 25.0/255.0, alpha: 1.0)
    }
    static var bumpOrange: UIColor {
        return UIColor(red: 247.0/255, green: 133/255, blue: 27/255, alpha: 1.0)
    }
    static var bumpBlue: UIColor {
        return UIColor(red: 61/255, green: 114/255, blue: 209/255, alpha: 1.0)
    }
    static var bumpBlack: UIColor {
        return UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1.0)
    }
    static var placeHolderGray: UIColor {
        return UIColor(red: 199/255, green: 199/255, blue: 205/255, alpha: 1.0)
    }
    static var placeHolderDarkGray: UIColor {
        return UIColor(red: 122/255, green: 121/255, blue: 123/255, alpha: 1.0)
    }
    static var cursorDarkBlue: UIColor {
        return UIColor(red: 44/255, green: 52/255, blue: 255/255, alpha: 1.0)
    }
}

extension UIColor {
    static func rawValueRGB(rawRed: Int, rawGreen: Int, rawBlue: Int, alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(rawRed)/255.0, green: CGFloat(rawGreen)/255.0, blue: CGFloat(rawBlue)/255.0, alpha: alpha)
        
    }
}

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    /**
     Initialize a new UIColor from a hex value
     
     - parameter hex: The hex integer (0x______) representation of the color
     */
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
    /**
     Initialize a UIColor based on provided RGB value in integer
     - parameter red:   Red Value in integer (0-255)
     - parameter green: Green Value in integer (0-255)
     - parameter blue:  Blue Value in integer (0-255)
     - returns: UIColor with specified RGB values
     */
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
}
