//
//  UserProfileView.swift
//  ogre
//
//  Created by Aaron Grizzle on 10/15/23.
//

import SwiftUI
import FirebaseAnalyticsSwift

struct UserProfileView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    @State var presentingConfirmationDialog = false
    
    @State var navigateToFriendsView = false
    @State private var tokens: Int = 0
    @State private var streak: Int = 0
    @State private var email: String = ""
    @State private var membership: String = ""
    @State private var difficulties: String = ""
    @State private var subjects: String = ""
    
    private func deleteAccount() {
        Task {
            if await viewModel.deleteAccount() == true {
                dismiss()
            }
        }
    }
    
    private func signOut() {
        viewModel.signOut()
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 100 , height: 100)
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .clipped()
                                .padding(4)
                                .overlay(Circle().stroke(Color.accentColor, lineWidth: 2))
                            Spacer()
                        }
                        Button(action: {}) {
                            Text("edit")
                        }
                    }
                }
                .listRowBackground(Color(UIColor.systemGroupedBackground))
                Section("Email") {
                    Text("\(email)")
                        .onAppear {
                            email = UserDataManager.getUserEmail()
                        }
                }
                
                Section(){
                    NavigationLink(destination: FriendsView()) {
                        HStack {
                            Spacer()
                            Text("Friends")
                            Spacer()
                        }
                    }
                }
                
                Section("Tokens"){
                    Text("Tokens: \(tokens)")
                        .onAppear {
                            UserDataManager.getTokens { result in
                                tokens = result
                            }
                        }
                }
                Section("Membership"){
                    Text("Membership: \(membership)")
                        .onAppear {
                            UserDataManager.getPremiumStatus() { premium in
                                if premium {
                                    membership = "Premium"
                                } else {
                                    membership = "Standard"
                                }
                            }
                        }
                }
                Section("Daily Question Streak"){
                    Text("Streak: \(streak)")
                        .onAppear {
                            UserDataManager.getDailyStreak() { result in
                                streak = result
                            }
                        }
                }
                
                Section(){
                    Text("Percent of attempted questions which you answered correctly")
                    Text("\(difficulties)")
                        .onAppear {
                            UserDataManager.readUserData(userId: UserDataManager.getUserId(), element: "difficulties") { data in
                                if let diffs = data as? [String: [String: Int]] {
                                    var result: [String] = []
                                    for (name, values) in diffs {
                                        if let correct = values["answeredCorrectly"], let total = values["attempted"], total != 0 {
                                            let percentage = Double(correct) / Double(total) * 100
                                            result.append("\(name): \(String(format: "%.0f", percentage))%")
                                        }
                                    }
                                    let sortedResult = result.sorted()
                                    DispatchQueue.main.async {
                                        self.difficulties = sortedResult.joined(separator: "\n")
                                    }
                                }
                            }
                        }
                }
                
                Section("Subjects"){
                    Text("\(subjects)")
                        .onAppear {
                            UserDataManager.readUserData(userId: UserDataManager.getUserId(), element: "subjects") { data in
                                if let diffs = data as? [String: [String: Int]] {
                                    var result: [String] = []
                                    for (name, values) in diffs {
                                        if let correct = values["answeredCorrectly"], let total = values["attempted"], total != 0 {
                                            let percentage = Double(correct) / Double(total) * 100
                                            result.append("\(name): \(String(format: "%.0f", percentage))%")
                                        }
                                    }
                                    let sortedResult = result.sorted()
                                    DispatchQueue.main.async {
                                        self.subjects = sortedResult.joined(separator: "\n")
                                    }
                                }
                            }
                        }
                }
                    
                    Section {
                        Button(role: .cancel, action: signOut) {
                            HStack {
                                Spacer()
                                Text("Sign out")
                                Spacer()
                            }
                        }
                    }
                    Section {
                        Button(role: .destructive, action: { presentingConfirmationDialog.toggle() }) {
                            HStack {
                                Spacer()
                                Text("Delete Account")
                                Spacer()
                            }
                        }
                    }
                }
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                .analyticsScreen(name: "\(Self.self)")
                .confirmationDialog("Deleting your account is permanent. Do you want to delete your account?",
                                    isPresented: $presentingConfirmationDialog, titleVisibility: .visible) {
                    Button("Delete Account", role: .destructive, action: deleteAccount)
                    Button("Cancel", role: .cancel, action: { })
                }
            }
        }
    }
    
    struct UserProfileView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationStack {
                UserProfileView()
                    .environmentObject(AuthenticationViewModel())
            }
        }
    }

