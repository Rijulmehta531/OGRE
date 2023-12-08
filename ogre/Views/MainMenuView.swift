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
import UserNotifications

let name = "Rao"


struct MainMenuView: View {
    @State private var showNotificationRequest = false
    @State private var selectedTab: Tab = .house
    
    @State var quizMode = false
    @State var isQOTDPopoverPresented = false
    
    @StateObject var quizManager = QuizManager()
    @State var streakAlert = QOTDView(closePopover: {})
    @State var streakCount = 0
    //@EnvironmentObject var quizManager: QuizManager
    //@EnvironmentObject var viewModel: AuthenticationViewModel
    @State var isSoundEnabled = true
    
    //variables for handling premium
    @State private var tokens: Int = 0
    @State var isPremiumEnabled: Bool = false
    @State private var showPremiumAlert: Bool = false
    //
    
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
                                Text("Welcome! 👋")
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
                            if isPremiumEnabled {
                                StudyView()
                            }else{
                                PremiumLockedView()
                            }
                            
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
                                    Toggle(isOn: $isPremiumEnabled) {
                                                Text("Premium")
                                            }
                                            .onChange(of: isPremiumEnabled) { newValue in
                                                if newValue && tokens < 30 {
                                                    isPremiumEnabled = false
                                                    showPremiumAlert = true
                                                }
                                                else{
                                                    UserDataManager.setPremiumStatus(status: newValue)
                                                }
                                            }
                                            .alert(isPresented: $showPremiumAlert) {
                                                Alert(title: Text("Insufficient Tokens"), message: Text("You need \(30 - tokens) more tokens to enable Premium."), dismissButton: .default(Text("OK")))
                                            }
                                            .onAppear {
                                                UserDataManager.getTokens { result in
                                                    tokens = result
                                                }
                                            }
                                }}
                            
                        } else if selectedTab == Tab.person {
                            UserProfileView()
                                .environmentObject(AuthenticationViewModel())
                        } else {
                            if isPremiumEnabled{
                                LeaderboardView()
                            }
                            else{
                                PremiumLockedView()
                            }
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
                message: Text("You have a \(streakCount) day streak! See you tomorrow!"),
                primaryButton: .default(Text("OK")) {
                    
                },
                secondaryButton: .cancel()
                )
        }
        .onAppear{
            checkForPermission()
            UserDataManager.getPremiumStatus { status in
                            isPremiumEnabled = status
                        }
            
        }
    }
    func checkForPermission(){
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings{settings in
            switch settings.authorizationStatus {
            case .authorized:
                self.dispatchNotification()
            case .denied:
                return
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { didAllow, error in
                    if didAllow{
                        self.dispatchNotification()
                    }
                }
            default:
                return
            }}
    }
    func dispatchNotification(){
        let identifier = "my-morning-notification"
        let title = "Don't break your streak"
        let body = "Open the app to keep your streak going."
        let hour = 00
        let minute = 15
        let isDaily = true
        
        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
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
                UserDataManager.getDailyStreak { streak in
                    streakCount = streak
                    showQOTDAlert = true
                }
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
