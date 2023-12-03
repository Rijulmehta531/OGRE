//
//  UIApplication+RootViewController.swift
//  ogre
//
//  Created by Aaron Grizzle on 10/15/23.
//

import Foundation
import UIKit

extension UIApplication {
  var currentKeyWindow: UIWindow? {
    UIApplication.shared.connectedScenes
      .compactMap { ($0 as? UIWindowScene)?.keyWindow }
      .first
  }

  var rootViewController: UIViewController? {
    currentKeyWindow?.rootViewController
  }
}
