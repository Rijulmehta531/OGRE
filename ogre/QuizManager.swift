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
    

    @Published var questionIndex = 0
    @Published var questionCategory = "quantitative-reasoning"
  
    
    
    @Published var questionsForPost: [String] = []
    @Published var selectedAnswers: [[AttributedString]] = []
    @Published var correctAnswers: [[String]]=[]
    //variables for text type responses.
    @Published var shortAns : String = ""
    @Published var longAns : String = ""
    @Published var numberOfQuizzesTaken = 0
    @Published var numTokens = 0
    
    @Published var isSubmitButtonPressed: Bool = false{
        didSet {
                if isSubmitButtonPressed {
                    if question?.type == "small_text", !shortAns.isEmpty {
                        let answerText = AttributedString(shortAns)
                           let answer = Answer(text: answerText, isCorrect: false) // Adjust 'isCorrect' as needed
                           goToNextQuestion(answer: answer)
                    } else if let answer = currentAnswer {
                        goToNextQuestion(answer: answer)
                    }
                }
            }
    }
    
    
    init(){
        UserDataManager.getEligibleQuestion(category: self.questionCategory) { result in
            self.questionIndex = result
            print("Question ID: \(self.questionIndex)")
        }
        
        Task.init{
            await fetchQuestionForDQOD(at: questionIndex, questionCategory: questionCategory)
            UserDataManager.getEligibleQuestion(category: self.questionCategory) { result in
                self.questionIndex = result
            }
            
        }

    }
    
    //Normal fetch question for practice and quiz mode
    func fetchQuestion (at index: Int, questionCategory: String) async {
        let ref = Database.database().reference(withPath: "question-data/\(questionCategory)/\(index)")

        ref.observeSingleEvent(of: .value) { (snapshot,error)  in
            guard let questionData = snapshot.value as? [String: Any] else {
                print("Failed to fetch question at index \(index) for category \(questionCategory)")
                return
            }

            var answers: [Answer] = []
            if let rawAnswers = questionData["answers"] as? [String] {
                let correctAnswers = (questionData["correct"] as? [String] ?? []).map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                answers = rawAnswers.map {
                    let trimmedAnswer = $0.trimmingCharacters(in: .whitespacesAndNewlines)
                    return Answer(text: AttributedString(trimmedAnswer), isCorrect: correctAnswers.contains(trimmedAnswer))
                }
            }

            let correctAny = questionData["correct"] as Any
            var correct: [String] = []

            if let correctString = correctAny as? String {
                correct = [correctString]
            } else if let correctArray = correctAny as? [String] {
                correct = correctArray
            }

            let question = QuestionObject(
                id: questionData["id"] as? Int ?? 0,
                type: questionData["type"] as? String ?? "",
                instructions: questionData["instructions"] as? String ?? "",
                description: questionData["description"] as? String ?? "",
                header: questionData["header"] as? String ?? "",
                answers: answers,
                correct: correct,
                difficulty: questionData["difficulty"] as? String ?? "",
                subject: questionData["subject"] as? [String] ?? [],
                descriptionHtml: questionData["description-html"] as? String ?? "",
                textExplanation: questionData["text-explanation"] as? String ?? ""
            )

            DispatchQueue.main.async {
                self.question = question
                
               

                self.questionsForPost.append(question.descriptionHtml)

                self.correctAnswers.append(question.correct)
                
            }
        } withCancel: { error in
            print("Failed to fetch question at index \(index) for category \(questionCategory): \(error.localizedDescription)")
        }
    }
    
    
    
    //Function to fetch DQOD and not append to post quiz screen
    func fetchQuestionForDQOD (at index: Int, questionCategory: String) async {
        let ref = Database.database().reference(withPath: "question-data/\(questionCategory)/\(index)")

        ref.observeSingleEvent(of: .value) { (snapshot,error)  in
            guard let questionData = snapshot.value as? [String: Any] else {
                print("Failed to fetch question at index \(index) for category \(questionCategory)")
                return
            }

            var answers: [Answer] = []
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
                //The question is added for the post quiz screen display.
                
//                self.correctAnswers.append(question.correct)
                print("Fetched question at index \(index) for category \(questionCategory) DQOD !!")
                
            }
        } withCancel: { error in
            print("DQOD !! Failed to fetch question at index \(index) for category \(questionCategory): \(error.localizedDescription)")
        }
    }

    

    
    //Function to chek the answer in the practice view and create a popup accordingly
    func checkAnswer() {
        if question?.type == "small_text" {
            if shortAns == question?.correct[0] {
                // The answer is correct
                SoundManager.instance.playSound(sound: .corrrect)
                feedbackMessage = question?.textExplanation ?? "You got it correct!"
                feedbackColor = Color.green
            } else {
                // The answer is incorrect
                SoundManager.instance.playSound(sound: .incorrect)
                feedbackMessage =  question?.textExplanation ?? "You got it wrong :("
                feedbackColor = Color.red
            }
        } else if let selectedAnswer = currentAnswer {
            if selectedAnswer.isCorrect {
                SoundManager.instance.playSound(sound: .corrrect)
                feedbackMessage = question?.textExplanation ?? "You got it correct!"
                feedbackColor = Color.green
            } else {
                SoundManager.instance.playSound(sound: .incorrect)
                feedbackMessage = question?.textExplanation ?? "You got it wrong :("
                feedbackColor = Color.red
            }
        }
    }

    
    func goToNextQuestion(answer: Answer){
        
        DispatchQueue.main.async {
//            if self.question?.type == "short_answer"{
//                self.shortAns = ""
//            }
//            if self.question?.type == "long_answer"{
//                self.longAns = ""
//            }
            
            
            self.selectedAnswers.append([answer.text])
            
            
            print(self.selectedAnswers)
            self.isSubmitButtonPressed = false
            if answer.isCorrect{
                self.score+=1
                
                UserDataManager.answeredQuestion(questionId: self.questionIndex, category: self.questionCategory, correct: true)
                if self.question?.difficulty=="Easy"{
                    self.numTokens += 2
                    print((self.question?.difficulty ?? "nil") + String(self.numTokens))
                    
                }
                else if self.question?.difficulty=="Medium"{
                    self.numTokens += 5
                    print((self.question?.difficulty ?? "nil") + String(self.numTokens))
                   
                }
                else if self.question?.difficulty=="Hard"{
                    self.numTokens += 7
                    print((self.question?.difficulty ?? "nil") + String(self.numTokens))
                   
                }
                else if self.question?.difficulty == "Very Hard"{
                    self.numTokens += 10
                    print((self.question?.difficulty ?? "nil") + String(self.numTokens))
                    
                }
            } else {
                UserDataManager.answeredQuestion(questionId: self.questionIndex, category: self.questionCategory, correct: false)
            }
            if self.index + 1 < self.length {
                UserDataManager.getEligibleQuestion(category: self.questionCategory) { result in
                    self.questionIndex = result
                    print("I AM INSIDE GOTONEXTQUESTION MF Question ID: \(self.questionIndex)")
                }
                
                self.index+=1
                self.setQuestion()
            } else {
                self.reachedEnd = true
            }
        }
        
       
    }

    
    func setQuestion() {
        print("setQuestion called with index \(questionIndex)")
        currentAnswer = nil

        Task{
            await fetchQuestion(at: self.questionIndex, questionCategory: self.questionCategory)
        }

            self.answerSelected = false
            self.progress = CGFloat(Double(self.index + 1) / Double(self.length) * 350)
    }
    
    func selectedAnswer(answer: Answer){
        //answerSelected = true
        currentAnswer = answer
        selectedAnswer = answer
    }
}
