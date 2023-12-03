//
//  AnswerButtonView.swift
//  OGRE Prototype
//
//  Created by Aaron Grizzle on 10/8/23.
//

import SwiftUI

struct AnswerButtonView: View {
    let answer: String
    var body: some View {
        HStack() {
            Text(answer)
                .font(.headline)
            Spacer()
        }
        .padding()
        .background(.purple)
        .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
        .cornerRadius(8)
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
}

#Preview {
    AnswerButtonView(answer: QuestionData.sampleQuestions[0].answers[0])
}
