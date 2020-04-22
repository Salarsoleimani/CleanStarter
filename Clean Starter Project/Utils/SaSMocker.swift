//
//  SaSMocker.swift
//  DoSomething
//
//  Created by Salar Soleimani on 2020-04-18.
//  Copyright © 2020 Salar Soleimani. All rights reserved.
//

import Foundation

public struct SaSMocker<T: Codable> {
  static func loadGenericObjectsFromLocalJson(fileName: String) -> [T] {
    let path = Bundle.main.path(forResource: fileName, ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
    
    let objects = try! JSONDecoder().decode([T].self, from: data)
    return objects
    
  }
  
  static func loadGenericObjectFromLocalJson(fileName: String) -> T {
    let path = Bundle.main.path(forResource: fileName, ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
    
    let object = try! JSONDecoder().decode(T.self, from: data)
    return object
  }
}
