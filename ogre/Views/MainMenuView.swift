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
    @State var isQOTDPopoverPresented = false
    
    @StateObject var quizManager = QuizManager()
    @State var streakAlert = QOTDView(closePopover: {})
   
    
    //@EnvironmentObject var quizManager: QuizManager
    //@EnvironmentObject var viewModel: AuthenticationViewModel
    @State var isSoundEnabled = true
    @State private var lastClickTimestamp: Date?
    @State private var showQOTDAlert = false
    @State private var showStreakAlert = false
    
    

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
                                    .frame(width: 250)
                                    .padding(.bottom, 100.0)
                                    Spacer()
                                    VStack() {
                                        Button() {
                                            handleClick()
                                            
                                            
                                        } label: {
                                            
                                            Image(systemName: "flame.fill")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 80, height: 85)
                                                    .foregroundColor(.orange)
                                            
                                        }
                                       
                                    }
                                    
                                    .padding()
                                    .background(.purple)
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                                    .cornerRadius(16)
                                    .frame(width: 100)
                                    .padding(.bottom, 100.0)
                                    Spacer()
                                    
                                }
                                
                            }
                        } else if selectedTab == Tab.book {
                            StudyView()
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
                            LeaderboardView()
                        }
                    }
                }
                VStack {
                    Spacer()
                    TabBar(selectedTab: $selectedTab)
                }
            }
        }
        .popover(isPresented: $isQOTDPopoverPresented) {
            QOTDView(closePopover: {
                isQOTDPopoverPresented.toggle()
            })
            .environmentObject(QuizManager())
        }
        .alert(isPresented: $showQOTDAlert) {
            Alert(
                title: Text("Streak"),
                message: Text("You have a \(streakAlert.streakCount) day streak! See you tomorrow!"),
                primaryButton: .default(Text("OK")) {
                    
                },
                secondaryButton: .cancel()
                )
        }
        
        
    }
    private func isButtonDisabled() -> Bool {
            // Check if the button was clicked today
            if let lastClickTimestamp = lastClickTimestamp {
                let calendar = Calendar.current
                return calendar.isDateInToday(lastClickTimestamp)
            } else {
                return false
            }
        }
    private func handleClick() {
            if isButtonDisabled() {
                showQOTDAlert = true
            } else {
                isQOTDPopoverPresented = true
                saveButtonClickTimestamp()
            }
        }
    private func saveButtonClickTimestamp() {
            // Save the current timestamp to UserDefaults
            lastClickTimestamp = Date()
            UserDefaults.standard.set(lastClickTimestamp, forKey: "lastClickTimestamp")
        }
    
}

#Preview {
    MainMenuView()
        .environmentObject(QuizManager())
        .environmentObject(AuthenticationViewModel())
}
