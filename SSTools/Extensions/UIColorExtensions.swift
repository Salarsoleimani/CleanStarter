//
//  UIColorExtensions.swift
//  SSTools
//
//  Created by Salar Soleimani on 2020-04-21.
//  Copyright © 2020 BeKSaS. All rights reserved.
//

import UIKit

public extension UIColor {
  /**
   Creates an UIColor from HEX String in "#363636" format
   
   - parameter hexString: HEX String in "#363636" format
   
   - returns: UIColor from HexString
   */
  convenience init(hex: String) {
    let r, g, b, a: CGFloat
    
    if hex.hasPrefix("#") {
      let start = hex.index(hex.startIndex, offsetBy: 1)
      let hexColor = String(hex[start...])
      
      if hexColor.count == 8 {
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
          r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
          g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
          b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
          a = CGFloat(hexNumber & 0x000000ff) / 255
          
          self.init(red: r, green: g, blue: b, alpha: a)
          return
        }
      }
    }
    self.init(red: 0, green: 0, blue: 0, alpha: 1)
    return
  }
  
  static func UITraitCollectionColor(darkModeHexString: String, lightModeHexString: String) -> UIColor {
    let darkModeColor = UIColor(hex: darkModeHexString)
    let lightModeColor = UIColor(hex: lightModeHexString)
    if #available(iOS 13, *) {
      return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
        if UITraitCollection.userInterfaceStyle == .dark {
          /// Return the color for Dark Mode
          return darkModeColor
        } else {
          /// Return the color for Light Mode
          return lightModeColor
        }
      }
    } else {
      /// Return a fallback color for iOS 12 and lower.
      return darkModeColor
    }
  }
  
  static func UITraitCollectionColor(darkModeColor: UIColor, lightModeColor: UIColor) -> UIColor {
    if #available(iOS 13, *) {
      return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
        if UITraitCollection.userInterfaceStyle == .dark {
          /// Return the color for Dark Mode
          return darkModeColor
        } else {
          /// Return the color for Light Mode
          return lightModeColor
        }
      }
    } else {
      /// Return a fallback color for iOS 12 and lower.
      return darkModeColor
    }
  }
}
