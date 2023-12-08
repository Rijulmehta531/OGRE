//
//  TestUserDataView.swift
//  ogre
//
//  Created by Aaron Grizzle on 11/21/23.
//

import SwiftUI
import Firebase

struct TestUserDataView: View {
    @State private var userId: String = ""
    @State private var email: String = ""
    @State private var element: String = ""
    @State private var value: String = ""
    @State private var result: String = ""

    var body: some View {
        VStack {
            HStack {
                Text("Result: \(result)")
                    .font(.headline)
                Spacer()
            }
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    GroupBox() {
                        Button("Get User ID") {
                            
                            // Use this function to get the UUID.
                            result = UserDataManager.getUserId()
                            
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    GroupBox() {
                        TextField("Element Name", text: $element)
                        Button("Read User Data") {
                            
                            // Use this function to read some user data.
                            UserDataManager.readUserData(userId: UserDataManager.getUserId(), element: element) { data in
                                // Example usage:
                                if let data = data {
                                    result = String(describing: data)
                                } else {
                                    result = ""
                                }
                            }
                            
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    GroupBox() {
                        TextField("Element Name", text: $element)
                        TextField("Value", text: $value)
                        Button("Write User Data") {
                            
                            // Use this function to write some user data.
                            UserDataManager.writeUserData(userId: UserDataManager.getUserId(), element: element, value: value)
                            
                            result = ""
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    GroupBox() {
                        TextField("Element Name", text: $element)
                        TextField("Value", text: $value)
                        Button("Push User Data") {
                            
                            // Use this function to push some user data.
                            UserDataManager.writeUserData(userId: UserDataManager.getUserId(), element: element, value: value)
                            
                            result = ""
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    GroupBox() {
                        Button("Initialize Current User") {
                            
                            // Use this function to initialize the user data.
                            UserDataManager.initializeUserData()
                            
                            result = ""
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    GroupBox() {
                        Button("Get Daily Streak") {
                            
                            // Use this function to get the daily streak.
                            UserDataManager.getDailyStreak() { streak in
                                // "streak" is an integer.
                                // Example usage:
                                result = String(describing: streak)
                            }
                            
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    GroupBox() {
                        Button("Add Daily Streak") {
                            
                            // Use this function to add 1 to the daily streak.
                            UserDataManager.addDailyStreak()
                            
                            result = ""
                        }
                        .frame(maxWidth: .infinity)
                    }
                    GroupBox() {
                        Button("Reset Daily Streak") {
                            
                            // Use this function to reset the daily streak to 0.
                            UserDataManager.resetDailyStreak()
                            
                            result = ""
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    GroupBox() {
                        Button("Get Friends") {
                            
                            // Use this function to get all friends.
                            UserDataManager.getFriends { friends in
                                // "friends" is an array of strings.
                                // Example usage:
                                if let friends = friends {
                                    result = friends.joined(separator: ", ")
                                } else {
                                    result = ""
                                }
                            }
                            
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    GroupBox() {
                        TextField("User ID", text: $userId)
                        Button("Is Friend") {
                            
                            // Use this function to see if a friend already exists.
                            UserDataManager.isFriend(userId: userId) { isFriend in
                                // "isFriend" is a Boolean.
                                // Example usage:
                                if isFriend {
                                    result = "User is a friend"
                                } else {
                                    result = "User is not a friend"
                                }
                            }
                            
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    GroupBox() {
                        TextField("Email", text: $email)
                        Button("Get Friend ID") {
                            
                            // Use this function to get a UUID from email.
                            UserDataManager.getFriendId(email: email) { UUID in
                                // "UUID" is a string.
                                // Example usage:
                                result = UUID
                            }
                            
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    GroupBox() {
                        TextField("Email", text: $email)
                        Button("Add Friend") {
                            
                            // Use this function to add a friend.
                            UserDataManager.addFriend(email: email)
                            
                            result = ""
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    GroupBox() {
                        Button("Get Tokens") {
                            
                            // Use this function to get the token count.
                            UserDataManager.getTokens() { tokens in
                                // "tokens" is an integer.
                                // Example usage:
                                result = String(describing: tokens)
                            }
                            
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    GroupBox() {
                        Button("Add Token") {
                            
//                            // Use this function to add 1 to the token count.
//                            UserDataManager.addToken()
                            
                            result = ""
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    GroupBox() {
                        Button("Get Premium Status") {
                            
                            // Use this function to get the premium membership status.
                            UserDataManager.getPremiumStatus() { status in
                                // "status" is a Boolean.
                                // Example usage:
                                if status {
                                    result = "Premium membership enabled"
                                } else {
                                    result = "Premium membership disabled"
                                }
                            }
                            
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    GroupBox() {
                        Button("Set Premium Status") {
                            
                            // Use this function to set the premium membership status.
                            UserDataManager.setPremiumStatus(status: true)
                            
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    GroupBox() {
                        Button("Get Sound Enabled") {
                            
                            // Use this function to get the sound setting.
                            UserDataManager.getSoundEnabled() { enabled in
                                // "enabled" is a Boolean.
                                // Example usage:
                                if enabled {
                                    result = "Sound enabled"
                                } else {
                                    result = "Sound disabled"
                                }
                            }
                            
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    GroupBox() {
                        Button("Set Sound Enabled") {
                            
                            // Use this function to set the sound setting.
                            UserDataManager.setSoundEnabled(status: false)
                            
                            result = ""
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                }
            }
        }
        .padding()
    }
}

struct TestUserDataView_Previews: PreviewProvider {
    static var previews: some View {
        TestUserDataView()
    }
}
