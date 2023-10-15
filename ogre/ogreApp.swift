//
//  ogreApp.swift
//  ogre
//
//  Created by Aaron Grizzle on 10/14/23.
//

import SwiftUI
import FirebaseCore


// Initialize Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


@main
struct OGRE_PrototypeApp: App {
    
    // Initialize Firebase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        
    }
    var body: some Scene {
        WindowGroup {
            OnboardingView()
        }
    }
}
