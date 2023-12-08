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
                    //        Text(viewModel.displayName)
                }
                Section("Tokens"){
                    Text("Tokens: \(tokens)")
                        .onAppear {
                            UserDataManager.getTokens { result in
                                tokens = result
                            }
                        }
                }
                    
                    Section("Friends"){
                        NavigationLink(destination: FriendsView()) {
                            HStack {
                                Spacer()
                                Text("Friends")
                                Spacer()
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

