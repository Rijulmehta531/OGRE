//
//  QuizView.swift
//  ogre
//
//  Created by Samujjwal Kumar on 10/15/23.
//

import SwiftUI

struct QuizView: View {
    @EnvironmentObject var quizManager: QuizManager
    
    @Binding var quizMode: Bool
    @State private var navigateToMainMenu = false
    
    var body: some View {
            if quizManager.reachedEnd {
                
                PostQuizScreen()
                    .navigationBarHidden(true)
                    
                HStack {
                    Button{
                        Task.init{
                            await quizManager.fetchQuiz()
                        }
                        
                    }label: {
                        PrimaryButton(text: "Next Quiz")
                    }
                
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
                    QuestionView()
                        .environmentObject(quizManager)
                        .navigationBarHidden(true)
                }
                else{
                    PracticeQuestionView()
                        .environmentObject(quizManager)
                        .navigationBarHidden(true)
                }
                
                
            }
            
        }
    }
    

#Preview {
    QuizView(quizMode: .constant(true))
        .environmentObject(QuizManager())
}
