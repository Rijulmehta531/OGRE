//
//  FriendsView.swift
//  ogre
//
//  Created by Rijul Mehta on 11/25/23.
//
import Firebase
import SwiftUI

struct Friend: Identifiable {
    let emailAddress: String
    let id = UUID()
}


struct FriendsView: View {
    @State var email: String = ""
    @State var userIsPresent: Bool = false
    @State var isShowingpopup: Bool = false
    @State var isFriendAlready: Bool = false
    
    @State private var friends: [Friend] = []
    
    var body: some View {
        ZStack {
            VStack{
                Text("Add a friend to share progress!")
                    .font(.custom("Optima-Bold", size: 26, relativeTo: .title2))
                    .foregroundColor(Color.accentColor)
                Spacer()
                TextField("Enter an email", text: $email)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                    .frame(width: 350)
                    .textCase(.lowercase)
            
                Button{
                    //                addFriend()
                    isShowingpopup = true
                    UserDataManager.checkIfUserExists(email: email.lowercased()
                    ) { userExists in
                        if userExists {
                            var friendToCheck = Friend(emailAddress: email.lowercased())
                            
                            if friends.contains(where: { $0.emailAddress == friendToCheck.emailAddress }) {
                                print("The friend is in the friends array.")
                                userIsPresent = true
                                isFriendAlready = true
                            } else {
                                print("The friend is not in the friends array.")
                                // If the user exists and is not a friend
                                userIsPresent = true
                                isFriendAlready = false
                                friends.append(Friend(emailAddress: email.lowercased()))
                                UserDataManager.addFriend(email: email.lowercased())
                                email = ""
                            }
                            
                                
                        } else {
                            userIsPresent = false
                            print("No user with the email \(email) exists.")
                        }
                    }
                    
                } label: {
                    PrimaryButton(text: "Add Friend")
                }
            
                
                HStack{
                    Spacer()
                    Text("Here's a list of your friends: ")
                    Spacer()
                }
            
                    List(friends, id: \.id) { friend in
                            Text(friend.emailAddress)
                        }
                    .frame(height: 500)
                    
            }
            .onAppear{
                UserDataManager.getFriends { friendUserIds in
                    if let friendUserIds = friendUserIds {
                        for id in friendUserIds {
                            UserDataManager.getFriendEmail(UUID: id) { email in
                                self.friends.append(Friend(emailAddress: email))
                            }
                        }
                    }
                }
            }
            if(isShowingpopup)
            {
                VStack(spacing: 20) {
                    ScrollView{
                        Text(userIsPresent ? isFriendAlready ? "You're friends already!" : "You're friends now!" : "Couldn't find user")
                            .foregroundColor(Color.white)
                        // A button to dismiss the pop up window
                        Button(action: {
                            // Set the isShowingPopUp variable to false
                            isShowingpopup = false
                        }) {
                            Text("Close")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(userIsPresent ? isFriendAlready ? Color.blue : Color.green : Color.red)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                    }
                    .frame(width:370 ,height:200)
                }
                // A background with rounded corners for the pop up window
                .padding()
                .background(Color.black.opacity(0.8))
                .cornerRadius(20)
                // An offset modifier to show or hide the pop up window based on the isShowingPopUp variable
                // The offset value is calculated based on the height of the screen and the pop up window
                //.offset(y: isShowingPopUp ? 0 : UIScreen.main.bounds.height)
                .position(x:UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 120)
                // An animation modifier to add some transition effects to the pop up window
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
        }
        
    }
    
}

#Preview {
    FriendsView()
}
