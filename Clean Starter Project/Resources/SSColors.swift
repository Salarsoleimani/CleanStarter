//
//  SSColors.swift
//  Clean Starter Project
//
//  Created by Salar Soleimani on 2020-04-21.
//  Copyright © 2020 BeKSaS. All rights reserved.
//

import Foundation
import UIKit

enum SSColors {
  case background
  case text
  
  case lightGray
  case lightGreen
  case yellow
  case lightRed
  case darkRed
  case lightPurple
  
  case custom(hexString: String, alpha: Double)
  case customWithDarkModeString(hexStringForDarkMode: String, hexStringForLightMode: String, alpha: Double)
  case customWithDarkModeColor(colorForDarkMode: UIColor, colorForLightMode: UIColor, alpha: Double)
  
  func withAlpha(_ alpha: Double) -> UIColor {
    return self.value.withAlphaComponent(CGFloat(alpha))
  }
}

extension SSColors {
  
  var value: UIColor {
    var instanceColor = UIColor.clear
    
    switch self {
    case .background:
      instanceColor = UIColor.UITraitCollectionColor(darkModeColor: UIColor(hex: "#28272C"), lightModeColor: UIColor.white)
    case .text:
      instanceColor = UIColor.UITraitCollectionColor(darkModeColor: UIColor(hex: "#ececec"), lightModeColor: UIColor(hex: "#9B9B9B"))
    case .lightGray:
      instanceColor = UIColor(hex: "3C3C42")
      
    case .lightGreen:
      instanceColor = UIColor(hex: "43CF71")
    case .yellow:
      instanceColor = UIColor(hex: "FBBD42")
    case.darkRed:
      instanceColor = UIColor(hex: "C30A0D")
    case .lightRed:
      instanceColor = UIColor(hex: "F6474A")
    case .lightPurple:
      instanceColor = UIColor(hex: "816CFF")
      
    case .custom(let hexString, let opacity):
      instanceColor = UIColor(hex: hexString).withAlphaComponent(CGFloat(opacity))
    case .customWithDarkModeString(let hexStringForDarkMode, let hexStringForLightMode, let opacity):
      instanceColor = UIColor.UITraitCollectionColor(darkModeHexString: hexStringForDarkMode, lightModeHexString: hexStringForLightMode).withAlphaComponent(CGFloat(opacity))
    case .customWithDarkModeColor(let colorForDarkMode, let colorForLightMode, let opacity):
      UIColor.UITraitCollectionColor(darkModeColor: colorForDarkMode, lightModeColor: colorForLightMode).withAlphaComponent(CGFloat(opacity))
    }
    return instanceColor
  }
}

