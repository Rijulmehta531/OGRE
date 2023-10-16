//
//  InitiQuesView.swift
//  ogre
//
//  Created by Rijul Mehta on 10/15/23.
//

import SwiftUI
struct AnswerView: View {
    @Binding var selectedAnswer: String
       let answerText: String

       var body: some View {
           RoundedRectangle(cornerRadius: selectedAnswer == answerText ? 15 : 5)
               .fill(selectedAnswer == answerText ? Color.accentColor : Color.white)
               .frame(height: 40)
               .overlay(
                   Text(answerText)
                       .foregroundColor(selectedAnswer == answerText ? Color.white : Color.primary)
               )
               .overlay(
                        RoundedRectangle(cornerRadius: selectedAnswer == answerText ? 15 : 5)
                        .stroke(selectedAnswer == answerText ? Color.black : Color.accentColor, lineWidth: 2)
                          )
               .shadow(color: Color.accentColor.opacity(0.3), radius: 5, x: 0, y: 3) // Add a shadow
               .onTapGesture {
                   selectedAnswer = answerText
               }
       }
}


struct InitiQuesView: View {
    var body: some View {
        FirstView()
    }
}

struct FirstView: View{
        @State var text=""
        @State private var selectedAnswer: String = ""
        var body:some View{
            VStack(spacing:20){
                HStack{
                    Text("OGRE")
                        .font(.title2)
                        .kerning(1.1)
                        .fontWeight(.bold)
                        .foregroundColor(.accentColor)
                    
                    Spacer()
                    
                    Text("1 out of 3")
                        .foregroundColor(Color.accentColor)
                        .fontWeight(.heavy)
                }
                Spacer()
                Text("Let's get you started ...")
                    .font(.title3)
                    .fontWeight(.bold)
                    .offset(x:-72,y:-280)
                
                Text("On a scale of 1-5, 1 being the least, how confident are you in Verbal Reasoning ?").bold()
                    .font(.title3)
                    .offset(y:-230)
                Group{
                    AnswerView(selectedAnswer: $selectedAnswer, answerText: "1")
                    AnswerView(selectedAnswer: $selectedAnswer, answerText: "2")
                    AnswerView(selectedAnswer: $selectedAnswer, answerText: "3")
                    AnswerView(selectedAnswer: $selectedAnswer, answerText: "4")
                    AnswerView(selectedAnswer: $selectedAnswer, answerText: "5")
                    
                }.offset(y:-230)
            }.padding()
                .navigationBarHidden(true)
        }
    
        
    }
#Preview {
    InitiQuesView()
}

