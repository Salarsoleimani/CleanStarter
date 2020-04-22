//
//  SplashViewModel.swift
//
//  Created by Behrad Kazemi on 12/29/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import Foundation
import UIKit

final class SplashViewModel {
  
  private let navigator: SplashNavigator
  let scalePop: CGFloat = 0.05
  init( navigator: SplashNavigator) {
    self.navigator = navigator
  }
  func goToHomePage(handler: (()->())?) {
    if !Defaults.isOnboardingWatched {
      navigator.toOnboarding()
      return
    }
    navigator.toHome()
  }
}
