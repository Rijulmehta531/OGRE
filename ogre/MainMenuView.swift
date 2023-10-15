//
//  MainMenuView.swift
//  OGRE Prototype
//
//  Created by Brian Johnson on 10/10/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import GoogleSignIn
import GoogleSignInSwift

let name = "Rao"

struct MainMenuView: View {
    @State private var selectedTab: Tab = .house
    
    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $selectedTab) {
                    if selectedTab == Tab.house {
                        VStack(alignment: .leading) {
                            Text("Welcome, \(name)! 👋")
                                .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                                .frame(maxWidth: .infinity)
                                .padding(.bottom, 16)
                                .foregroundColor(.white)
                                .background(.purple)
                            Spacer()
                            CategorySelector()
                            HStack {
                                Spacer()
                                LaunchQuestions()
                                    .padding(.bottom, 100.0)
                                Spacer()
                            }
                        }
                    } else if selectedTab == Tab.book {
                        Text("Study Materials Under Construction")
                    } else if selectedTab == Tab.gearshape {
                        Text("Settings Under Construction")
                    } else if selectedTab == Tab.person {
                        Text("Profile Under Construction")
//                        VStack {
//                            Button(action: {}) {
//                                Text("Sign In with Google")
//                            }
//                            .buttonStyle(.bordered)
//                        }
                    } else {
                        Text("Leaderboard Under Construction")
                    }
                }
            }
            VStack {
                Spacer()
                TabBar(selectedTab: $selectedTab)
            }
        }
    }
}

#Preview {
    MainMenuView()
}
