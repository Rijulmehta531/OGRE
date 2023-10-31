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

            .navigationBarHidden(true)
    }
}

struct FirstView: View {
    @State private var selectedAnswer: String = ""
    @EnvironmentObject var quizManager: QuizManager
    @State private var isNavigationActive: Bool = false
    @State var currentPage = 1
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if currentPage <= 3 {
                    HStack {
                        Text("OGRE")
                            .font(.title2)
                            .kerning(1.1)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                        
                        Spacer()
                        
                        Text("\(currentPage) out of 3")
                            .foregroundColor(Color.accentColor)
                            .fontWeight(.heavy)
                    }
                    Spacer()
                    Text("Let's get you started ...")
                        .font(.title3)
                        .fontWeight(.bold)
                        .offset(x: -72, y: -200)
                    if currentPage == 1 {
                        Text("On a scale of 1-5, 1 being the least, how confident are you in Verbal Reasoning?").bold()
                            .font(.title3)
                        .offset(y: -200)}
                    else if currentPage == 2{
                        Text("On a scale of 1-5, 1 being the least, how confident are you in Quantitative Reasoning?").bold()
                            .font(.title3)
                        .offset(y: -200)}
                    else if currentPage == 3{
                            Text("On a scale of 1-5, 1 being the least, how confident are you in Analytical Writing?").bold()
                                .font(.title3)
                                .offset(y: -200)}
                    
                    Group {
                        AnswerView(selectedAnswer: $selectedAnswer, answerText: "1")
                        AnswerView(selectedAnswer: $selectedAnswer, answerText: "2")
                        AnswerView(selectedAnswer: $selectedAnswer, answerText: "3")
                        AnswerView(selectedAnswer: $selectedAnswer, answerText: "4")
                        AnswerView(selectedAnswer: $selectedAnswer, answerText: "5")
                    }
                    .offset(y: -190)
                    Button(action: {
                        currentPage += 1
                    }) {
                        PrimaryButton(text: "Next")
                    }
                    .offset(y: -130)
                } else {
                    VStack(spacing: 20){
                        Image("obj1")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .offset(y:100)
                        Spacer().frame(height: 100)
                        Text("Thank You, We've got your responses and are ready to customize your journey to ace the GRE! Happy Learning")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer().frame(height: 50)
                        
                        NavigationLink(
                            destination: MainMenuView(),
                            isActive: $isNavigationActive,
                            label: {
                                PrimaryButton(text: "Go to Main Menu")
                            }
                        )}
                    .offset(y: -130)
                }
            }
            .padding()
        }
    }
}



struct ScreenV: View{
    var question: String
    
    @State var currentPage = 1
    var body: some View{
        VStack{
            Text(question)
                
        }
    }
}

#Preview {
    InitiQuesView()
}

