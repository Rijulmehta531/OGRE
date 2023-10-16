//
//  Answer.swift
//  ogre
//
//  Created by Samujjwal Kumar on 10/15/23.
//

import Foundation

struct Answer: Identifiable {
    var id = UUID()
    var text: AttributedString
    var isCorrect: Bool
}
