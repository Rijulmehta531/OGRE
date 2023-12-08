//
//  Checkbox.swift
//  ogre
//
//  Created by Rijul Mehta on 11/19/23.
//

import Foundation
import SwiftUI


struct CheckboxToggleStyle: ToggleStyle {
    @EnvironmentObject var quizManager: QuizManager
    var answer: Answer

    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
            if configuration.isOn {
                quizManager.answerSelected = true
                quizManager.selectedAnswer(answer: answer)
                quizManager.isShowingPopup = false
            }
        }) {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                configuration.label
            }
        }
    }
}


struct Checkbox: View {
    @EnvironmentObject var quizManager: QuizManager
    
    var answer: Answer
    var isSelected: Bool{
        quizManager.selectedAnswer == answer
    }
    
    @State var isAnswerSelected = false
    
    var green = Color(hue: 0.437, saturation: 0.771, brightness: 0.771)
    var red = Color(red: 0.71, green: 0.094, blue: 0.1)
    
    var body: some View {
        HStack(spacing: 20){
            Toggle(isOn: $isAnswerSelected) {
            }
            .toggleStyle(CheckboxToggleStyle(answer: answer))
            
            
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
            if !isAnswerSelected {
                    isAnswerSelected.toggle()
            }
            quizManager.answerSelected = true
            quizManager.selectedAnswer(answer: answer)
            quizManager.isShowingPopup = false
        }
    }
}

#Preview {
    Checkbox(answer: Answer(text:"Single",isCorrect: false))
        .environmentObject(QuizManager())
}
