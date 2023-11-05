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

struct PostQuizScreen: View {
    @EnvironmentObject var quizManager: QuizManager
    
    // Use the custom function to convert the arrays
    var selectedAnswers: [IdentifiableAttributedString] {
        convertToIdentifiableArray(quizManager.selectedAnswers)
    }
    
    var questions: [IdentifiableAttributedString] {
        convertToIdentifiableArray(quizManager.questionsForPost)
    }
    
    var correctAnswers: [IdentifiableAttributedString] {
    convertToIdentifiableArray(quizManager.correctAnswers)
    }
    
    var body: some View {
        VStack{
            ScrollView{
                Text("Viola! My Friend...")
                    .lilacTitle()
                    .multilineTextAlignment(.center)
                Image("obj4-thumbsup")
                    .resizable()
                    .frame(width: 180, height: 200)
                
                Text("Here's a detailed summary of your quiz:")
                    .fontWeight(.bold)
                    .foregroundColor(Color.accentColor)
                
                let combined = Array(zip(zip(questions, selectedAnswers), correctAnswers)).map { ($0.0, $0.1, $1) }

                ForEach(combined, id: \.0.id) { question, selected, correct in
                    let isCorrect = selected.content.string == correct.content.string

                    DisclosureGroup(
                        content: {
                            VStack(alignment: .leading) {
                                Text("Correct Answer:")
                                    .font(.headline)
                                Text(verbatim: correct.content.string)
                                    .font(.subheadline)
                                    .padding(.bottom)
                                Text(isCorrect ? "Well done!" : "Better luck next time!")
                                    .font(.body)
                            }
                            .padding()
                        }, label: {
                            HStack {
                                Text(verbatim: question.content.string)
                                    .font(.headline)
                                Spacer()
                                Text(verbatim: selected.content.string)
                                    .font(.subheadline)
                                // Apply a green or red color depending on the correctness
                                    .foregroundColor(isCorrect ? .green : .red)
                                    .fontWeight(.bold)
                            }
                            .padding()
                        }
                    )
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

#Preview {
    PostQuizScreen()
        .environmentObject(QuizManager())
}
