//
//  UIViewControllerExtensions.swift
//  SSTools
//
//  Created by Salar Soleimani on 2020-04-21.
//  Copyright © 2020 BeKSaS. All rights reserved.
//

import UIKit

public extension UIViewController {
  static func initFromNib() -> Self {
    func instanceFromNib<T: UIViewController>() -> T {
      return T(nibName: String(describing: self), bundle: nil)
    }
    return instanceFromNib()
  }
}
