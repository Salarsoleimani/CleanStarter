//
//  SSFonts.swift
//  Clean Starter Project
//
//  Created by Salar Soleimani on 2020-04-21.
//  Copyright © 2020 BeKSaS. All rights reserved.
//

import UIKit

struct SSFonts {
  enum FontType {
    case installed(FontFamily, FontStyle)
    case custom(String)
    case system
    case systemBold
    case systemItatic
    case systemWeighted(weight: CGFloat)
    case monoSpacedDigit(size: CGFloat, weight: CGFloat)
  }
  enum FontSize {
    case standard(StandardSize)
    case custom(CGFloat)
    var value: CGFloat {
      switch self {
      case .standard(let size):
        return size.rawValue * CGFloat(Defaults.fontScale)
      case .custom(let customSize):
        return customSize
      }
    }
  }
  enum FontFamily: String {
//    case barlowCondensed              = "BarlowCondensed"
//    case playfairDisplay              = "PlayfairDisplay"
//    case nunito                       = "Nunito"
    case montserrat                   = "Montserrat"
//    case merriweather                 = "Merriweather"
//
//    case aristotelicaDisplayRegular   = "AristotelicaDisplayTrial-Regula"
//    case aristotelicaDisplayBold      = "AristotelicaDisplayTrial-DemiBo"
  }
  enum FontStyle: String {
    case none = ""
    case regular = "-Regular"
    case bold = "-Bold"
  }
  enum StandardSize: CGFloat {
    case h1 = 22.0
    case h2 = 20.0
    case h3 = 18.0
    case h4 = 16.0
    case h5 = 14.0
    case h6 = 12.0
    case h7 = 10.0
    case h8 = 8.0
  }
  
  var type: FontType
  var size: FontSize
  init(_ type: FontType, size: FontSize) {
    self.type = type
    self.size = size
  }
}

extension SSFonts {
  var instance: UIFont {
    
    var instanceFont: UIFont!
    switch type {
    case .custom(let fontName):
      guard let font =  UIFont(name: fontName, size: CGFloat(size.value)) else {
        fatalError("\(fontName) font is not installed, make sure it added in Info.plist and logged with Utility.logAllAvailableFonts()")
      }
      instanceFont = font
    case .installed(let fontFamilyName, let fontStyle):
      
      let fontName = fontFamilyName.rawValue + fontStyle.rawValue
      guard let font =  UIFont(name:fontName, size: CGFloat(size.value)) else {
        fatalError("\(fontName) font is not installed, make sure it added in Info.plist and logged with Utility.logAllAvailableFonts()")
      }
      instanceFont = font
    case .system:
      instanceFont = UIFont.systemFont(ofSize: size.value)
    case .systemBold:
      instanceFont = UIFont.boldSystemFont(ofSize: size.value)
    case .systemItatic:
      instanceFont = UIFont.italicSystemFont(ofSize: size.value)
    case .systemWeighted(let weight):
      instanceFont = UIFont.systemFont(ofSize: size.value, weight: UIFont.Weight.init(rawValue: weight))
    case .monoSpacedDigit(let size, let weight):
      instanceFont = UIFont.monospacedDigitSystemFont(ofSize: size, weight: UIFont.Weight.init(rawValue: weight))
    }
    return instanceFont
  }
}
