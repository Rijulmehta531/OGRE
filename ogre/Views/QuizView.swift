//
//  QuizView.swift
//  ogre
//
//  Created by Samujjwal Kumar on 10/15/23.
//

import SwiftUI

struct QuizView: View {
    @EnvironmentObject var quizManager: QuizManager
    var body: some View {
        if quizManager.reachedEnd {
            VStack(spacing: 20){
                    Text("OGRE")
                        .lilacTitle()
                    
                    Text("Congratulations! Quiz Completed!  🥳")
                    
                    Text("You got \(quizManager.score) out of \(quizManager.length) questions correct.\n\n")
                    Text("Answers you got wrong:")
                    Text("Sample Wrong Answer Explanation ")
                    Text("Sample Wrong Answer Explanation ")
                    Text("Sample Wrong Answer Explanation \n")
                
                Button{
                    Task.init{
                        await quizManager.fetchQuiz()
                    }
                    
                }label: {
                    PrimaryButton(text: "Next Quiz")
                }
                Spacer()
                
                }
                .foregroundColor(Color("AccentColor"))
                .padding()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        } else{
            QuestionView()
                .environmentObject(quizManager)
        }
        
    }
}

#Preview {
    QuizView()
        .environmentObject(QuizManager())
}
