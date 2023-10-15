
//  QuestionView.swift
//  OGRE Prototype
//
//  Created by Aaron Grizzle on 10/7/23.
//

import SwiftUI
struct QuestionView: View {
    
    let questionData: QuestionData
    var body: some View {
        VStack {
            //for progress bar
            ProgressView(value: 0.1)
                .padding()
                .frame(width: 350, height: 90)
                .accentColor(.purple)
                
                
//            Image("Image")
            Spacer()
        }
        Spacer()
        VStack {
            
            Text(questionData.question)
                .font(.title)
            VStack {
                Spacer()
                ForEach(questionData.answers, id: \.self) { answer in
                    AnswerButton(answer: answer)
                    
                }
                
                Spacer()
                
            }

        }
        .padding(0.0)
    }
}

#Preview {
    QuestionView(questionData: QuestionData.sampleQuestions[0])
}
