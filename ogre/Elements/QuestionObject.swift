//
//  QuestionObject.swift
//  ogre
//
//  Created by Aaron Grizzle on 11/11/23.
//

import Foundation

struct QuestionObject: Identifiable {
    let id: Int
    let type: String
    let instructions: String
    let description: String
    let header: String
    let answers: [Answer]
    let correct: [String]
    let difficulty: String
    let subject: [String]
    let descriptionHtml: String
    let textExplanation: String
}
