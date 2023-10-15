//
//  ogreApp.swift
//  ogre
//
//  Created by Aaron Grizzle on 10/14/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore

//// Initialize Firebase
//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(
//        _ application: UIApplication,
//        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
//    ) -> Bool {
//        FirebaseApp.configure()
//        Auth.auth().useEmulator(withHost: "localhost", port: 9099)
//        return true
//    }
//}
//
//
//@main
//struct OGRE_PrototypeApp: App {
//    
//    // Initialize Firebase
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    
//    init() {
//        
//    }
//    var body: some Scene {
//        WindowGroup {
//            MainMenuView()
//                .environment(\.font, Font.custom("Optima", size: 14))
//        }
//    }
//}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
//    Auth.auth().useEmulator(withHost:"localhost", port:9099)
    return true
  }
}

@main
struct ogreApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        AuthenticatedView {
        } content: {
            MainMenuView()
        }
      }
    }
  }
}
