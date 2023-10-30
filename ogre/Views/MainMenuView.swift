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
    @State private var useTimer = false
    @StateObject var quizManager = QuizManager()
    //@EnvironmentObject var quizManager: QuizManager
    //@EnvironmentObject var viewModel: AuthenticationViewModel

    var body: some View {
        NavigationView {
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
                                    VStack() {
                                        Toggle(
                                            "Timer",
                                            systemImage: "timer",
                                            isOn: $useTimer
                                        )
                                        .font(.custom("Optima-Bold", size: 22, relativeTo: .title2))
                                        NavigationLink(
                                            destination: QuizView()
                                                .environmentObject(quizManager),
                                            label: {
                                                Text("Start")
                                                .font(.custom("Optima-ExtraBlack", size: 34, relativeTo: .largeTitle))
                                            }
                                        )
                                    }
                                    .padding()
                                    .background(.purple)
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                                    .cornerRadius(16)
                                    .frame(width: 300)
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
}

#Preview {
    MainMenuView()
}
