//
//  AnswerRow.swift
//  ogre
//
//  Created by Samujjwal Kumar on 10/15/23.
//

import Foundation
import SwiftUI

struct AnswerRow: View {
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
            
//            if isSelected {
//                Spacer()
//                Image(systemName: "")
//                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
////                Image(systemName: answer.isCorrect ? "checkmark.circle.fill" : "x.circle.fill")
////                    .foregroundColor(answer.isCorrect ? green : red)
//            }
            
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
    AnswerRow(answer: Answer(text:"Single",isCorrect: false))
        .environmentObject(QuizManager())
}
