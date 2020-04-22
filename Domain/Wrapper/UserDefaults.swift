//
//  UserDefaults.swift
//  Domain
//
//  Created by Salar Soleimani on 2020-04-21.
//  Copyright © 2020 BeKSaS. All rights reserved.
//

import Foundation

@propertyWrapper
public struct UserDefault<T> {
  let key: String
  let defaultValue: T
  
  public init(_ key: String, defaultValue: T) {
    self.key = key
    self.defaultValue = defaultValue
  }
  
  public var wrappedValue: T {
    get {
      return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
    }
    set {
      UserDefaults.standard.set(newValue, forKey: key)
    }
  }
}
