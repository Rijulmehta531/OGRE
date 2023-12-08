//
//  QuizView.swift
//  ogre
//
//  Created by Samujjwal Kumar on 10/15/23.
//

import SwiftUI
import Firebase

struct QuizModeHandler: View {
    @EnvironmentObject var quizManager: QuizManager
    
    @Binding var quizMode: Bool
    @State private var navigateToMainMenu = false
    
    var body: some View {
            if quizManager.reachedEnd {
                
                PostQuizScreen()
                    .navigationBarHidden(true)
                    
                HStack {
                    // NavigationLink for "Next Quiz" button
                    NavigationLink(destination: QuestionView()
                        .environmentObject(quizManager)
                        .navigationBarHidden(true)
                        .onAppear{
                            quizManager.length = 10
                            Task{await quizManager.fetchQuestion(at:quizManager.questionIndex, questionCategory: quizManager.questionCategory)
                            }}) {
                        PrimaryButton(text: "Next Quiz")
                    }
                    
                    // Existing "Main Menu" button and NavigationLink
                    Button {
                        navigateToMainMenu = true  // Set this to true when the button is tapped
                    }
                    label: {
                        PrimaryButton(text: "Main Menu", background: Color.accentColor)
                    }
                    
                    NavigationLink(destination: MainMenuView(), isActive: $navigateToMainMenu) {
                        EmptyView()
                    }
                }

                
                    
                    
                Spacer()
                
            }
            
            
            else{
                if quizMode{
//                    let db = Database.database().reference()
//                    db.child("users/\(self.userID)/numberOfQuizzesTaken").observeSingleEvent(of: .value) { snapshot in
//                        if let numberOfQuizzesTaken = snapshot.value as? Int {
//                            quizManager.numberOfQuizzesTaken = numberOfQuizzesTaken
//                        } else {
//                            // Handle the case where the value doesn't exist or isn't an Int
//                            quizManager.numberOfQuizzesTaken = 0
//                        }
//                    }
                    
                    
                    
                    QuestionView()
                        .environmentObject(quizManager)
                        .navigationBarHidden(true)
                        .onAppear{
                            quizManager.length = 10
                            Task{await quizManager.fetchQuestion(at:quizManager.questionIndex, questionCategory: quizManager.questionCategory)
                            }}
                }
                else{
                    PracticeQuestionView()
                        .environmentObject(quizManager)
                        .navigationBarHidden(true)
                        .onAppear{
                            quizManager.length = 500 //replace with total number of questions
                            Task{await quizManager.fetchQuestion(at:quizManager.questionIndex, questionCategory: quizManager.questionCategory)
                            }
                        }
                }
                
                
            }
            
        }
    }
    

#Preview {
    QuizModeHandler(quizMode: .constant(true))
        .environmentObject(QuizManager())
}
