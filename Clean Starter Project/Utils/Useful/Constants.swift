//
//  Constants.swift
//  Clean Starter Project
//
//  Created by Salar Soleimani on 2020-04-21.
//  Copyright © 2020 BeKSaS. All rights reserved.
//

import Foundation

enum Constants {
  enum Keys: String {
    case fontScale = "com.storageKey.fontScale"
    case fontFamily = "com.storageKey.fontFamily"
    
    case appOpenedCount = "com.storageKey.appOpenedCount"
    case isAdsRemoved = "com.storageKey.isAdsRemoved"
    case isOnboardingWatched = "com.storageKey.isOnboardingWatched"
  }
  enum Links: String {
    case instagram = "https://www.instagram.com/salarsoleimani"
    case email = "salar.soleimanii@gmail.com"
    case mailSubject = "issue"
  }
  enum GoogleAdUnitIds: String {
    // google testAdUnitIds
    case testAdBannerUnitID = "ca-app-pub-3940256099942544/2934735716"
    case testAdInterstitialUnitID = "ca-app-pub-3940256099942544/4411468910"
    case testAdInterstitialVideoUnitID = "ca-app-pub-3940256099942544/5135589807"
    case testAdRewardedVideoUnitID = "ca-app-pub-3940256099942544/1712485313"
    case testAdNativeAdvancedUnitID = "ca-app-pub-3940256099942544/3986624511"
    case testAdNativeAdvancedVideoUnitID = "ca-app-pub-3940256099942544/2521693316"
  }
}
