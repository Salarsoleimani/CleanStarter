//
//  ApplicationStarter.swift
//  Clean Starter Project
//
//  Created by Salar Soleimani on 2020-04-21.
//  Copyright © 2020 BeKSaS. All rights reserved.
//

import UIKit
import Domain
import Siren
import SwiftRater
import IQKeyboardManagerSwift

final class Application {
  static let shared = Application()
  
  private init() {

  }
  
  func configureMainInterface(in window: UIWindow?) {
    let mainNavigationController = MainNavigationController()
    window?.rootViewController = mainNavigationController
    window?.makeKeyAndVisible()
    SplashNavigator(navigationController: mainNavigationController).setup()
  }
  
  func setupApplicationConfigurations() {
    LanguageManager.shared.defaultLanguage = .deviceLanguage
    IQKeyboardManager.shared.enable = true
    setupRateManager()
    setupUpdateManager()
    resetNotificationBadge()
  }
  
  private func setupUpdateManager() {
    Siren.shared.wail()
    Siren.shared.rulesManager = RulesManager(majorUpdateRules: Rules(promptFrequency: .immediately, forAlertType: .force), minorUpdateRules: Rules(promptFrequency: .daily, forAlertType: .option), patchUpdateRules: Rules(promptFrequency: .weekly, forAlertType: .skip), revisionUpdateRules: Rules.default, showAlertAfterCurrentVersionHasBeenReleasedForDays: 3)
  }
  private func resetNotificationBadge() {
    UIApplication.shared.applicationIconBadgeNumber = 0
  }
  
  private func setupRateManager() {
    SwiftRater.alertCancelTitle = "Rate_alertCancelTitle".localize()
    SwiftRater.alertMessage = "Rate_alertMessage".localize()
    SwiftRater.alertRateLaterTitle = "Rate_alertRateLaterTitle".localize()
    SwiftRater.alertRateTitle = "Rate_alertRateTitle".localize()
    SwiftRater.alertTitle = "Rate_alertTitle".localize()
    
    SwiftRater.daysUntilPrompt = 2
    SwiftRater.usesUntilPrompt = 10
    SwiftRater.significantUsesUntilPrompt = 3
    SwiftRater.daysBeforeReminding = 1
    SwiftRater.showLaterButton = true
    SwiftRater.debugMode = true
    SwiftRater.appLaunched()
  }
  private func countUpAppOpened() {
    Defaults.appOpenedCount += 1
  }
  
}
