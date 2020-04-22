//
//  SplashNavigator.swift
//
//  Created by Behrad Kazemi on 12/29/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import SSTools

final class SplashNavigator: Navigator {
  func setup() {
    let vc = SplashController.initFromNib()
    vc.viewModel = SplashViewModel(navigator: self)
    navigationController.viewControllers = [vc]
  }
  
  func toOnboarding() {
    OnboardingNavigator(navigationController: navigationController).setup()
  }
  
  func toHome() {
    HomeNavigator(navigationController: navigationController).setup()
  }
}
