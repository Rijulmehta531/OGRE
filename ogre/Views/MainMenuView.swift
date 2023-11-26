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
    
    @State var quizMode = false
    
    @StateObject var quizManager = QuizManager()
    //@EnvironmentObject var quizManager: QuizManager
    //@EnvironmentObject var viewModel: AuthenticationViewModel
    @State var isSoundEnabled = true

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
                                    .environmentObject(quizManager)
                                HStack {
                                    Spacer()
                                    VStack() {
                                        Toggle(
                                            "Quiz Mode",
                                            systemImage: "timer",
                                            isOn: $quizMode
                                        )
                                        .font(.custom("Optima-Bold", size: 22, relativeTo: .title2))
                                        NavigationLink(
                                            destination: QuizModeHandler(quizMode: $quizMode)
                                                .environmentObject(quizManager),
                                            label: {
                                                Text("Start")
                                                .font(.custom("Optima-ExtraBlack", size: 34, relativeTo: .largeTitle))
                                            }
                                        )
                                        .navigationBarHidden(true)
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
                        } 
                        else if selectedTab == Tab.gearshape {
                            VStack{
                                Text("Settings")
                                    .lilacTitle()
                                List{
                                    Toggle(isOn: $isSoundEnabled) {
                                        Text("Sounds")
                                    }
                                    .onReceive([self.isSoundEnabled].publisher.first()) { value in
                                        SoundManager.isSoundEnabled = value
                                    }
                                }}
                            
                        } else if selectedTab == Tab.person {
                            UserProfileView()
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
