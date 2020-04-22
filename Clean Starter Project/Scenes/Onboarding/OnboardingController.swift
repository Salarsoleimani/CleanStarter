//
//  OnboardingController.swift
//  ListHub
//
//  Created by Salar Soleimani on 2020-04-14.
//  Copyright © 2020 BEKSAS. All rights reserved.
//

import UIKit

class OnboardingController: UIViewController {
  // MARK:- Outlets

  // MARK:- variables
  var viewModel: OnboardingViewModel!
  
  // MARK:- Constants

  // MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  // MARK:- Actions

  // MARK:- Functions
  private func setupUI() {
    view.backgroundColor = SSColors.background.value
  }
}
