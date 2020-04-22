//
//  LanguageManager.swift
//  ListHub
//
//  Created by Salar Soleimani on 2020-04-14.
//  Copyright © 2020 BEKSAS. All rights reserved.
//

import UIKit
import Domain

// Base on https://github.com/Abedalkareem/LanguageManager-iOS

public class LanguageManager {
  
  public typealias Animation = ((UIView) -> Void)
  public typealias ViewControllerFactory = ((String?) -> UIViewController)
  public typealias WindowAndTitle = (UIWindow?, String?)
  
  ///
  /// The singleton LanguageManager instance.
  ///
  public static let shared: LanguageManager = LanguageManager()
  
  ///
  /// The current language.
  ///
  public var currentLanguage: Languages {
    get {
      guard let currentLang = UserDefaults.standard.string(forKey: LanguageManagerConstants.defaultsKeys.selectedLanguage) else {
        fatalError("Did you set the default language for the app?")
      }
      return Languages(rawValue: currentLang)!
    }
    set {
      UserDefaults.standard.set(newValue.rawValue, forKey: LanguageManagerConstants.defaultsKeys.selectedLanguage)
    }
  }
  
  ///
  /// The default language that the app will run first time.
  /// You need to set the `defaultLanguage` in the `AppDelegate`, specifically in
  /// the first line inside `application(_:willFinishLaunchingWithOptions:)`.
  ///
  public var defaultLanguage: Languages {
    get {
      guard let defaultLanguage = UserDefaults.standard.string(forKey: LanguageManagerConstants.defaultsKeys.defaultLanguage) else {
        fatalError("Did you set the default language for the app?")
      }
      return Languages(rawValue: defaultLanguage)!
    }
    set {
      
      // swizzle the awakeFromNib from nib and localize the text in the new awakeFromNib
      UIView.localize()
      
      let defaultLanguage = UserDefaults.standard.string(forKey: LanguageManagerConstants.defaultsKeys.defaultLanguage)
      guard defaultLanguage == nil else {
        setLanguage(language: currentLanguage)
        return
      }
      
      var language = newValue
      if language == .deviceLanguage {
        language = deviceLanguage ?? .en
      }
      
      UserDefaults.standard.set(language.rawValue, forKey: LanguageManagerConstants.defaultsKeys.defaultLanguage)
      UserDefaults.standard.set(language.rawValue, forKey: LanguageManagerConstants.defaultsKeys.selectedLanguage)
      setLanguage(language: language)
    }
  }
  
  ///
  /// The device language is deffrent than the app language,
  /// to get the app language use `currentLanguage`.
  ///
  public var deviceLanguage: Languages? {
    get {
      
      guard let deviceLanguage = Bundle.main.preferredLocalizations.first else {
        return nil
      }
      return Languages(rawValue: deviceLanguage)
    }
  }
  
  /// The diriction of the language.
  public var isRightToLeft: Bool {
    get {
      return isLanguageRightToLeft(language: currentLanguage)
    }
  }
  
  /// The app locale to use it in dates and currency.
  public var appLocale: Locale {
    get {
      return Locale(identifier: currentLanguage.rawValue)
    }
  }
  
  ///
  /// Set the current language of the app
  ///
  /// - parameter language: The language that you need the app to run with.
  /// - parameter windows: The windows you want to change the `rootViewController` for. if you didn't
  ///                      set it, it will change the `rootViewController` for all the windows in the
  ///                      scenes.
  /// - parameter viewControllerFactory: A closure to make the `ViewController` for a specific `scene`, you can know for which
  ///                                    `scene` you need to make the controller you can check the `title` sent to this clouser,
  ///                                    this title is the `title` of the `scene`, so if there is 5 scenes this closure will get called 5 times
  ///                                    for each scene window.
  /// - parameter animation: A closure with the current view to animate to the new view controller,
  ///                        so you need to animate the view, move it out of the screen, change the alpha,
  ///                        or scale it down to zero.
  ///
  public func setLanguage(language: Languages,
                          for windows: [WindowAndTitle]? = nil,
                          viewControllerFactory: ViewControllerFactory? = nil,
                          animation: Animation? = nil) {
    
    changeCurrentLanguageTo(language)
    
    guard let viewControllerFactory = viewControllerFactory else {
      return
    }
    
    let windowsToChange = getWindowsToChangeFrom(windows)
    
    windowsToChange?.forEach({ windowAndTitle in
      let (window, title) = windowAndTitle
      let viewController = viewControllerFactory(title)
      changeViewController(for: window,
                           rootViewController: viewController,
                           animation: animation)
    })
    
  }
  
  private func changeCurrentLanguageTo(_ language: Languages) {
    // change the dircation of the views
    let semanticContentAttribute: UISemanticContentAttribute = isLanguageRightToLeft(language: language) ? .forceRightToLeft : .forceLeftToRight
    UILabel.appearance().semanticContentAttribute = semanticContentAttribute
    UITextView.appearance().semanticContentAttribute = semanticContentAttribute
    
    // set current language
    currentLanguage = language
  }
  
  private func getWindowsToChangeFrom(_ windows: [WindowAndTitle]?) -> [WindowAndTitle]? {
    var windowsToChange: [WindowAndTitle]?
    if let windows = windows {
      windowsToChange = windows
    } else {
      if #available(iOS 13.0, *) {
        windowsToChange = UIApplication.shared.connectedScenes
          .compactMap({$0 as? UIWindowScene})
          .map({ ($0.windows.first, $0.title) })
      } else {
        windowsToChange = [(UIApplication.shared.keyWindow, nil)]
      }
    }
    
    return windowsToChange
  }
  
  private func changeViewController(for window: UIWindow?,
                                    rootViewController: UIViewController,
                                    animation: Animation? = nil) {
    guard let snapshot = window?.snapshotView(afterScreenUpdates: true) else {
      return
    }
    rootViewController.view.addSubview(snapshot);
    
    window?.rootViewController = rootViewController
    
    UIView.animate(withDuration: 0.5, animations: {
      animation?(snapshot)
    }) { _ in
      snapshot.removeFromSuperview()
    }
  }
  
  private func isLanguageRightToLeft(language: Languages) -> Bool {
    return false
    // Do it later and fix everywhere for farsi
    //return Locale.characterDirection(forLanguage: language.rawValue) == .rightToLeft
  }
  
}

// MARK: - Swizzling

fileprivate extension UIView {
  static func localize() {
    
    let orginalSelector = #selector(awakeFromNib)
    let swizzledSelector = #selector(swizzledAwakeFromNib)
    
    let orginalMethod = class_getInstanceMethod(self, orginalSelector)
    let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
    
    let didAddMethod = class_addMethod(self, orginalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
    
    if didAddMethod {
      class_replaceMethod(self, swizzledSelector, method_getImplementation(orginalMethod!), method_getTypeEncoding(orginalMethod!))
    } else {
      method_exchangeImplementations(orginalMethod!, swizzledMethod!)
    }
    
  }
  
  @objc func swizzledAwakeFromNib() {
    swizzledAwakeFromNib()
    
    switch self {
    case let txtf as UITextField:
      txtf.text = txtf.text?.localize()
      txtf.placeholder = txtf.placeholder?.localize()
    case let lbl as UILabel:
      lbl.text = lbl.text?.localize()
    case let tabbar as UITabBar:
      tabbar.items?.forEach({ $0.title = $0.title?.localize() })
    case let btn as UIButton:
      btn.setTitle(btn.title(for: .normal)?.localize(), for: .normal)
    case let sgmnt as UISegmentedControl:
      (0 ..< sgmnt.numberOfSegments).forEach { sgmnt.setTitle(sgmnt.titleForSegment(at: $0)?.localize(), forSegmentAt: $0) }
    case let txtv as UITextView:
      txtv.text = txtv.text?.localize()
    default:
      break
    }
  }
}

// MARK: - ImageDirection

public enum ImageDirection: Int {
  case fixed, leftToRight, rightToLeft
}

private extension UIView {
  ///
  /// Change the direction of the image depeneding in the language, there is no return value for this variable.
  /// The expectid values:
  ///
  /// -`fixed`: if the image must not change the direction depending on the language you need to set the value as 0.
  ///
  /// -`leftToRight`: if the image must change the direction depending on the language
  /// and the image is left to right image then you need to set the value as 1.
  ///
  /// -`rightToLeft`: if the image must change the direction depending on the language
  /// and the image is right to left image then you need to set the value as 2.
  ///
  var direction: ImageDirection {
    set {
      switch newValue {
      case .fixed:
        break
      case .leftToRight where LanguageManager.shared.isRightToLeft:
        transform = CGAffineTransform(scaleX: -1, y: 1)
      case .rightToLeft where !LanguageManager.shared.isRightToLeft:
        transform = CGAffineTransform(scaleX: -1, y: 1)
      default:
        break
      }
    }
    get {
      fatalError("There is no value return from this variable, this variable used to change the image direction depending on the langauge")
    }
  }
}

@IBDesignable
public extension UIImageView {
  ///
  /// Change the direction of the image depeneding in the language, there is no return value for this variable.
  /// The expectid values:
  ///
  /// -`fixed`: if the image must not change the direction depending on the language you need to set the value as 0.
  ///
  /// -`leftToRight`: if the image must change the direction depending on the language
  /// and the image is left to right image then you need to set the value as 1.
  ///
  /// -`rightToLeft`: if the image must change the direction depending on the language
  /// and the image is right to left image then you need to set the value as 2.
  ///
  @IBInspectable var imageDirection: Int {
    set {
      direction = ImageDirection(rawValue: newValue)!
    }
    get {
      return direction.rawValue
    }
  }
}

@IBDesignable
public extension UIButton {
  ///
  /// Change the direction of the image depeneding in the language, there is no return value for this variable.
  /// The expectid values:
  ///
  /// -`fixed`: if the image must not change the direction depending on the language you need to set the value as 0.
  ///
  /// -`leftToRight`: if the image must change the direction depending on the language
  /// and the image is left to right image then you need to set the value as 1.
  ///
  /// -`rightToLeft`: if the image must change the direction depending on the language
  /// and the image is right to left image then you need to set the value as 2.
  ///
  @IBInspectable var imageDirection: Int {
    set {
      direction = ImageDirection(rawValue: newValue)!
    }
    get {
      return direction.rawValue
    }
  }
}

// MARK: - Constants

fileprivate enum LanguageManagerConstants {
  
  enum defaultsKeys {
    static let selectedLanguage = "LanguageManagerSelectedLanguage"
    static let defaultLanguage = "LanguageManagerDefaultLanguage"
  }
  
  enum strings {
    static let unlocalized = "<unlocalized>"
  }
}
import Foundation

public enum Languages: String {
  case ar,en,nl,ja,ko,vi,ru,sv,fr,es,pt,it,de,da,fi,nb,tr,el,id,
  ms,th,hi,hu,pl,cs,sk,uk,hr,ca,ro,he,ur,fa,ku,arc,sl,ml,am
  case enGB = "en-GB"
  case enAU = "en-AU"
  case enCA = "en-CA"
  case enIN = "en-IN"
  case frCA = "fr-CA"
  case esMX = "es-MX"
  case ptBR = "pt-BR"
  case zhHans = "zh-Hans"
  case zhHant = "zh-Hant"
  case zhHK = "zh-HK"
  case es419 = "es-419"
  case ptPT = "pt-PT"
  case deviceLanguage
}

public enum LanguageId: Int16 {
  case EN, IR, CH
  public static let defaultValue = LanguageId.EN
}

extension LanguageId {
  public func asStringName() -> String {
    switch self {
    case .EN:
      return "English"
    case .IR:
      return "فارسی"
    case .CH:
      return "中文"
    }
  }
}
extension String {
  
  ///
  /// Localize the current string to the selected language
  ///
  /// - returns: The localized string
  ///
  
  func localize(comment: String = "") -> String {
    guard let currentLang = UserDefaults.standard.string(forKey: LanguageManagerConstants.defaultsKeys.selectedLanguage) else {
      fatalError("Did you set the default language for the app?")
    }
    guard let bundle = Bundle.main.path(forResource: Languages(rawValue: currentLang)!.rawValue, ofType: "lproj") else {
      return NSLocalizedString(self, comment: comment)
    }
    
    let langBundle = Bundle(path: bundle)
    return NSLocalizedString(self, tableName: nil, bundle: langBundle!, comment: comment)
  }
  
}
