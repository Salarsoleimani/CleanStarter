//
//  HomeViewModel.swift
//  Clean Starter Project
//
//  Created by Salar Soleimani on 2020-04-21.
//  Copyright © 2020 BeKSaS. All rights reserved.
//

import Domain

final class HomeViewModel: ViewModelType {
  private let navigator: HomeNavigator
  
  init(navigator: HomeNavigator) {
    self.navigator = navigator
  }
  func transform(input: HomeViewModel.Input) -> HomeViewModel.Output {
    return Output()
  }
}
extension HomeViewModel {
  struct Input {
    
  }
  struct Output {
    
  }
}
