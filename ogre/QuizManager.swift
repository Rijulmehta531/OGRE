//
//  QuizManager.swift
//  ogre
//
//  Created by Samujjwal Kumar on 10/15/23.
//

import Foundation
import SwiftUI
import Firebase


class QuizManager: ObservableObject{
    //private(set) var quiz: [Quiz.Result] = []

    @Published var length: Int = 10
    @Published private(set) var index = 0
    @Published private(set) var reachedEnd = false
    
    @Published var answerSelected: Bool = false
    //@Published private(set) var question: AttributedString = ""
    @Published private(set) var answerChoices: [Answer] = []
    @Published private(set) var progress: CGFloat = 0.00
    @Published private(set) var score = 0
    @Published var currentAnswer: Answer?
    @Published var selectedAnswer: Answer? //To keep track of highlighting and dehighlighting in answer row
    
    //variables to keep track of the popup in the practice view
    @Published var feedbackMessage = ""
    @Published var feedbackColor = Color.green
    @Published var isShowingPopup: Bool = false
    
    //Variables to fetch individual questions
    @Published var question: QuestionObject?
    @Published var questionIndex = 486
    @Published var questionCategory = "quantitative-reasoning"
  
    
    
    @Published var questionsForPost: [String] = []
    @Published var selectedAnswers: [AttributedString] = []
    @Published var correctAnswers: [AttributedString] = []
    //variables for text type responses.
    @Published var shortAns : String = ""
    @Published var longAns : String = ""
    
    @Published var isSubmitButtonPressed: Bool = false{
        didSet{
            if isSubmitButtonPressed, let answer = currentAnswer{
                Task {
                    await goToNextQuestion(answer: answer)
                    }
            }
        }
    }
    func fetchQuestion (at index: Int, questionCategory: String) async {
        let ref = Database.database().reference(withPath: "question-data/\(questionCategory)/\(index)")

        ref.observeSingleEvent(of: .value) { (snapshot,error)  in
//            print(snapshot.value)
            guard let questionData = snapshot.value as? [String: Any] else {
                print("Failed to fetch question at index \(index) for category \(questionCategory)")
                return
            }

            var answers: [Answer] = []

//            if let rawAnswers = questionData["answers"] as? [[String]] {
//                answers = rawAnswers
//            } else if let rawAnswer = questionData["answers"] as? [String] {
//                answers = [rawAnswer]
//            }
            if let rawAnswers = questionData["answers"] as? [String] {
                let correctAnswers = (questionData["correct"] as? [String] ?? []).map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                answers = rawAnswers.map {
                    let trimmedAnswer = $0.trimmingCharacters(in: .whitespacesAndNewlines)
                    return Answer(text: AttributedString(trimmedAnswer), isCorrect: correctAnswers.contains(trimmedAnswer))
                }
            }


            let question = QuestionObject(
                id: questionData["id"] as? Int ?? 0,
                type: questionData["type"] as? String ?? "",
                instructions: questionData["instructions"] as? String ?? "",
                description: questionData["description"] as? String ?? "",
                header: questionData["header"] as? String ?? "",
                answers: answers,
                correct: questionData["correct"] as? [String] ?? [],
                difficulty: questionData["difficulty"] as? String ?? "",
                subject: questionData["subject"] as? [String] ?? [],
                descriptionHtml: questionData["description-html"] as? String ?? "",
                textExplanation: questionData["text-explanation"] as? String ?? ""
            )

            DispatchQueue.main.async {
                self.question = question
                print("Fetched question at index \(index) for category \(questionCategory)")
            }
        } withCancel: { error in
            print("Failed to fetch question at index \(index) for category \(questionCategory): \(error.localizedDescription)")
        }
    }



    
    //Function to chek the answer in the practice view and create a popup accordingly
    func checkAnswer() {
        if let selectedAnswer = currentAnswer {
                    if selectedAnswer.isCorrect {
                        SoundManager.instance.playSound(sound: .corrrect)
                        // Set the feedback message and color to positive
                        feedbackMessage = question?.textExplanation ?? "You got it correct!"
                        feedbackColor = Color.green
                    } else {
                        SoundManager.instance.playSound(sound: .incorrect)
                        // Set the feedback message and color to negative
                        feedbackMessage = question?.textExplanation ?? "You got it wrong :("
                        feedbackColor = Color.red
                    }
                }
            }
    
    func goToNextQuestion(answer: Answer) async {
        DispatchQueue.main.async {
//            if self.question?.type == "short_answer"{
//                self.shortAns = ""
//            }
//            if self.question?.type == "long_answer"{
//                self.longAns = ""
//            }
            self.selectedAnswers.append(answer.text)
            self.questionsForPost.append(self.question?.descriptionHtml ?? "")
            print(self.selectedAnswers)
            self.isSubmitButtonPressed = false
            if answer.isCorrect{
                self.score+=1
            }
            if self.index + 1 < self.length {
                self.questionIndex += 1
                self.index+=1
            } else {
                self.reachedEnd = true
            }
        }
        await setQuestion()
    }

    
    func setQuestion() async {
        await fetchQuestion(at: self.questionIndex, questionCategory: self.questionCategory)
        DispatchQueue.main.async {
            self.answerSelected = false
            self.progress = CGFloat(Double(self.index + 1) / Double(self.length) * 350)
        }
    

        
//        if questionIndex < length {
//            let currentQuizQuestion = quiz[index]
//            print(currentQuizQuestion.description)
//            question = currentQuizQuestion.formattedQuestion
//            answerChoices = currentQuizQuestion.answers1
//            correctAnswers.append(currentQuizQuestion.cAns[0].text)
//            print("Correct answers array \(correctAnswers)")
//        }
    }
    
    func selectedAnswer(answer: Answer){
        //answerSelected = true
        currentAnswer = answer
        selectedAnswer = answer
    }
}
