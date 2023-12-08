//
//  PostQuizScreen.swift
//  ogre
//
//  Created by Samujjwal Kumar on 11/1/23.
//

import SwiftUI
import Foundation

// Define a custom struct that wraps AttributedString and conforms to Identifiable
struct IdentifiableAttributedString: Identifiable {
    let content: NSAttributedString
    let id = UUID() // Provide a unique identifier
}

func convertToIdentifiableArray(_ array: [AttributedString]) -> [IdentifiableAttributedString] {
    return array.map {
        // Create a new instance of NSAttributed String from Attributed string
        let nsAttributedString = NSAttributedString($0)
        // Return a new instance of IdentifiableAttributedString with the content
        return IdentifiableAttributedString(content: nsAttributedString)
    }
}
//For answers array which is a string array
func convertStringArrayToIdentifiableArray(_ array: [String]) -> [IdentifiableAttributedString] {
    return array.map {
        // Create a new instance of AttributedString from String
        let attributedString = AttributedString($0)
        // Create a new instance of NSAttributed String from Attributed string
        let nsAttributedString = NSAttributedString(attributedString)
        // Return a new instance of IdentifiableAttributedString with the content
        return IdentifiableAttributedString(content: nsAttributedString)
    }
}


struct PostQuizScreen: View {
    @EnvironmentObject var quizManager: QuizManager
    
    
    var body: some View {

        VStack{
            //            ScrollView{
            Text("Viola! My Friend...")
                .lilacTitle()
                .multilineTextAlignment(.center)
            Image("obj4-thumbsup")
                .resizable()
                .frame(width: 180, height: 200)
            
            Text("You scored : " + String(quizManager.score) + "/10")
                .fontWeight(.bold)
                .foregroundColor(Color.accentColor)
            Text("You earned : " + String(quizManager.numTokens) + " tokens!")
                .fontWeight(.bold)
                .foregroundColor(Color.accentColor)
            
            Text("Here's a detailed summary of your quiz:")
                .fontWeight(.bold)
                .foregroundColor(Color.accentColor)
            List {
                ForEach(Array(zip(quizManager.questionsForPost.indices, quizManager.questionsForPost)), id: \.0.self) { index, question in
                    DisclosureGroup(
                        content: {
                            ForEach(quizManager.correctAnswers[index], id: \.self) { answer in
                                let cleanedAnswer = answer.trimmingCharacters(in: CharacterSet(charactersIn: "\"[]"))
                                Text("Correct answer: " + cleanedAnswer)
                            }
                            ForEach(quizManager.selectedAnswers[index], id: \.self) { attributedAnswer in
                                                let selectedAnswer = attributedAnswer
                        
                                                Text("Your answer: " + selectedAnswer)
                                    .foregroundColor(Color.accentColor)
                                    
                                    }
                                        
                        },
                        
                        label: {
                            ScrollView {
                                WebView(htmlString: question)
                                    .frame(minHeight: 90)
                            }
                        }
                    )
                }
            }
//                List{
//                    ForEach(combined, id: \.0.id) { question, selected, correct in
//                        let isCorrect = selected.content.string == correct.content.string
//
//
//                        DisclosureGroup(
//                            content: {
//                                VStack(alignment: .leading) {
//                                    Text("You answered:")
//                                        .font(.headline)
//                                    //                                        .foregroundColor(Color.white)
//                                    Text(verbatim: selected.content.string)
//                                        .font(.subheadline)
//                                        .padding(.bottom)
//                                        .foregroundColor(Color.black)
//                                        .fontWeight(.bold)
//                                    Text("Correct Answer:")
//                                        .font(.headline)
//                                    //                                        .foregroundColor(Color.white)
//                                    Text(verbatim: correct.content.string)
//                                        .font(.subheadline)
//                                        .padding(.bottom)
//                                    //                                        .foregroundColor(Color.white)
//                                    Text(isCorrect ? "Well done!" : "Better luck next time!")
//                                        .font(.body)
//                                }
//                                .padding()
//                            }, label: {
//
//                                HStack {
//                                    WebView(htmlString: question.content.string)
//                                        .frame(minHeight: 100)
//                                }
//                                .padding()
//                            }
//
//
//                        )
//                        // .clipShape(RoundedRectangle(cornerRadius: 20))
//                        .border(isCorrect ? Color.green : Color.red, width: 2)
//                        //                    .cornerRadius(20)
//                        // Add a shadow with color based on the correctness
//                        //                    .shadow(color: isCorrect ? Color.green : Color.red, radius: 5)
//                        // .background(LinearGradient(gradient: Gradient(colors: [isCorrect ? Color.green : Color.red, .accentColor]), startPoint: .leading, endPoint: .trailing))
//
//                    }}
//                .cornerRadius(20)
            //            }
        }
        .frame(width: UIScreen.main.bounds.width)
        
        .onAppear(){
            UserDataManager.addTokens(numTokens: quizManager.numTokens)
            SoundManager.instance.playSound(sound: .quizEnd)
            
        } }
    
       
}

#Preview {
    PostQuizScreen()
        .environmentObject(QuizManager())
}
