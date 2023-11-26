//
//  MultipleRadio.swift
//  ogre
//
//  Created by Rijul Mehta on 11/21/23.
//

import SwiftUI

struct MultipleRadio: View {
        @EnvironmentObject var quizManager: QuizManager
        
        var answer: Answer
        var isSelected: Bool{
            quizManager.selectedAnswer == answer
        }
        
        var green = Color(hue: 0.437, saturation: 0.771, brightness: 0.771)
        var red = Color(red: 0.71, green: 0.094, blue: 0.1)
    var body: some View {
        HStack(spacing: 20){
            Image(systemName: "circle.fill")
                .font(.caption)
            
            Text(answer.text)
                .bold()
            

            
        }
        .padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading)
        .foregroundColor(quizManager.answerSelected ? (isSelected ? Color("AccentColor") : .gray) : Color("AccentColor"))
        .background(.white)
        .cornerRadius(10)
        .shadow(color: isSelected ? Color.blue : .gray, radius: 5, x: 0.5, y:0.5)
        .onTapGesture {
                quizManager.answerSelected = true
                quizManager.selectedAnswer(answer: answer)
                quizManager.isShowingPopup = false
            
        }
    }
}

#Preview {
    MultipleRadio(answer: Answer(text:"Single",isCorrect: false))
        .environmentObject(QuizManager())
}
