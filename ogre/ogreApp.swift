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

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
//        Auth.auth().useEmulator(withHost:"localhost", port:9099)
        return true
    }
}

@main
struct ogreApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authViewModel = AuthenticationViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                AuthenticatedView {
                    if authViewModel.hasCompletedOnboarding {
                                        MainMenuView()
                                    } else {
                                        OnboardingView()
                                    }
                }
                .environmentObject(authViewModel)
            }
        }
    }
}
