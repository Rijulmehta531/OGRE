//
//  QuestionData.swift
//  OGRE Prototype
//
//  Created by Aaron Grizzle on 10/8/23.
//

import Foundation

struct QuestionData {
    let category: String
    let question: String
    let answers: [String]
    let correctAnswer: Int // 0, 1, 2, or 3
}

extension QuestionData {
    static let sampleQuestions: [QuestionData] =
    [
        QuestionData(category: "Qualitative Reasoning",
                     question: "Sample question 1",
                     answers: ["Sample answer 1", "Sample answer 2", "Sample answer 3", "Sample answer 4"],
                     correctAnswer: 0),
        QuestionData(category: "Qualitative Reasoning",
                     question: "Sample question 2",
                     answers: ["Sample answer 1", "Sample answer 2", "Sample answer 3", "Sample answer 4"],
                     correctAnswer: 0),
        QuestionData(category: "Qualitative Reasoning",
                     question: "Sample question 1",
                     answers: ["Sample answer 1", "Sample answer 2", "Sample answer 3", "Sample answer 4"],
                     correctAnswer: 0)
    ]
}
