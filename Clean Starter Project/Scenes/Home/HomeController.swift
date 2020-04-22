//
//  ViewController.swift
//  Clean Starter Project
//
//  Created by Salar Soleimani on 2020-04-21.
//  Copyright © 2020 BeKSaS. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
  // MARK:- Constants
  var viewModel: HomeViewModel!
  // MARK:- Variables
  
  // MARK:- Outlets
  
  // MARK:- Life Cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  // MARK:- Functions
  private func setupUI() {
    view.backgroundColor = SSColors.background.value
  }
  // MARK:- Actions
}
