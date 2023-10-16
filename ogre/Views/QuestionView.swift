
//  QuestionView.swift
//  OGRE Prototype
//
//  Created by Sam Kumar 10/15/2023
//

import SwiftUI
struct QuestionView: View {
    @EnvironmentObject var quizManager: QuizManager
    
    var body: some View {
        VStack(spacing: 40) {
            HStack{
                Text("OGRE")
                    .lilacTitle()
                
                Spacer()
                
                Text("\(quizManager.index + 1) out of \(quizManager.length)")
                    .foregroundColor(Color.accentColor)
                    .fontWeight(.heavy)
            }
            ProgressBar(progress: quizManager.progress)
            
            VStack(alignment:.leading, spacing: 20){
                Text(quizManager.question)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.black)
                
                ForEach(quizManager.answerChoices, id: \.id){
                    answer in AnswerRow(answer: answer)
                        .environmentObject(quizManager)
                }
            }
            
            Button{
                quizManager.goToNextQuestion()
            } label: {
                PrimaryButton(text: "Next", background: quizManager.answerSelected ? Color("AccentColor") : Color(hue:1.0, saturation: 0.0, brightness: 0.564, opacity: 0.327))
            }
            .disabled(!quizManager.answerSelected)
            
            Spacer()
            
            
        }
        .padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
        .navigationBarHidden(true)
    }
}

#Preview {
    QuestionView()
        .environmentObject(QuizManager())
}
