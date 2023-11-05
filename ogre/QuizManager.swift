//
//  QuizManager.swift
//  ogre
//
//  Created by Samujjwal Kumar on 10/15/23.
//

import Foundation
import SwiftUI


class QuizManager: ObservableObject{
    private(set) var quiz: [Quiz.Result] = []
    @Published private(set) var length = 0
    @Published private(set) var index = 0
    @Published private(set) var reachedEnd = false
    
    @Published var answerSelected: Bool = false
    @Published private(set) var question: AttributedString = ""
    @Published private(set) var answerChoices: [Answer] = []
    @Published private(set) var progress: CGFloat = 0.00
    @Published private(set) var score = 0
    @Published var currentAnswer: Answer?
    @Published var selectedAnswer: Answer? //To keep track of highlighting and dehighlighting in answer row
    
    //variables to keep track of the popup in the practice view
    @Published var feedbackMessage = ""
    @Published var feedbackColor = Color.green
    @Published var isShowingPopup: Bool = false
    
    @Published var questionsForPost: [AttributedString] = []
    @Published var selectedAnswers: [AttributedString] = []
    @Published var correctAnswers: [AttributedString] = []
    
    @Published var isSubmitButtonPressed: Bool = false{
        didSet{
            if isSubmitButtonPressed, let answer = currentAnswer{
                goToNextQuestion(answer: answer)
            }
        }
    }
    
    init(){
        Task.init{
            await fetchQuiz()
        }
    }
    
    func fetchQuiz() async{
        selectedAnswers = []
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10") else { fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        do{
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error while fetching data")}
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(Quiz.self, from: data)
            
            DispatchQueue.main.async {
                self.index = 0
                self.score = 0
                self.progress = 0.00
                self.reachedEnd = false
                
                self.quiz = decodedData.results
                self.length = self.quiz.count
                self.setQuestion()
            }
            
        } catch{
            print("Error fetching quiz: \(error)")
        }
    }
    
    //Function to chek the answer in the practice view and create a popup accordingly
    func checkAnswer() {
        if let selectedAnswer = currentAnswer {
                    if selectedAnswer.isCorrect {
                        // Set the feedback message and color to positive
                        feedbackMessage = "You got it right!"
                        feedbackColor = Color.green
                    } else {
                        // Set the feedback message and color to negative
                        feedbackMessage = "Sorry, that's wrong."
                        feedbackColor = Color.red
                    }
                }
            }
    
    func goToNextQuestion(answer: Answer) {
        
        selectedAnswers.append(answer.text)
        questionsForPost.append(quiz[index].formattedQuestion)
  
        print(selectedAnswers)
        isSubmitButtonPressed = false
        if answer.isCorrect{
            score+=1
        }
        if index + 1 < length {
            index += 1
            setQuestion()
        } else {
            reachedEnd = true
        }
    }
    
    func setQuestion() {
        answerSelected = false
        progress = CGFloat(Double(index + 1) / Double(length) * 350)
        
        if index < length {
            let currentQuizQuestion = quiz[index]
            question = currentQuizQuestion.formattedQuestion
            answerChoices = currentQuizQuestion.answers
            correctAnswers.append(currentQuizQuestion.cAns[0].text)
            print("Correct answers array \(correctAnswers)")
        }
    }
    
    func selectedAnswer(answer: Answer){
        //answerSelected = true
        currentAnswer = answer
        selectedAnswer = answer
    }
}
