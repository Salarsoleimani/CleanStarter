//
//  Utility.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-02-29.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit

class Utility {
  class func shareText(text: String, view: UIViewController) {
    let textToShare = [ text ]
    let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = view.view
    activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
    view.present(activityViewController, animated: true, completion: nil)
  }
  
  class func openURL(url: String) {
    guard let url = URL(string: url) else { return }
    if #available(iOS 10.0, *) {
      DispatchQueue.main.async {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
      }
    } else {
      UIApplication.shared.openURL(url)
    }
  }
  
  class func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
      deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
  }
}
