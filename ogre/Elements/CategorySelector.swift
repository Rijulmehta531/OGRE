//
//  CategorySelector.swift
//  ogre
//
//  Created by Aaron Grizzle on 10/15/23.
//

import SwiftUI

struct CategorySelector: View {
    @EnvironmentObject var quizManager: QuizManager
    
    @State private var VRSelected = false
    @State private var QRSelected = false
    @State private var AWSelected = false
    
   
    

    
    var body: some View {
        VStack {
            Text("Select one or more categories:")
                .foregroundColor(.purple)
                .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    Category(
                        categoryName: "Verbal Reasoning",
                        categoryDescription: "Critical reading skills",
                        categoryIcon: "doc.text.magnifyingglass",
                        nameDB: "verbal-reasoning"
                        
                    )
                    .environmentObject(quizManager)
                    Category(
                        categoryName: "Quantitative Reasoning",
                        categoryDescription: "Numerical problem solving",
                        categoryIcon: "x.squareroot",
                        nameDB: "quantitative-reasoning"
                    )
                    .environmentObject(quizManager)
                    
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .safeAreaPadding(.horizontal, 44)
        }
        .frame(height: 360)
    }
}

struct Category: View {
    @EnvironmentObject var quizManager: QuizManager
    let categoryName: String
    let categoryDescription: String
    let categoryIcon: String
    let nameDB: String
    @State private var categorySelected = false
   
    
    var body: some View {
        Button(action: {
            self.categorySelected.toggle()
            quizManager.questionCategory = nameDB
        }) {
            ZStack() {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(categorySelected ? .green : .purple)
                    .frame(width: 300, height: 300)
                VStack {
                    Text(categoryName)
                        .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    Text(categoryDescription)
                        .font(.custom("Optima-Bold", size: 17, relativeTo: .body))
                    Image(systemName: categoryIcon)
                        .frame(height: 120)
                        .font(.system(size: 96))
                }
                .foregroundColor(.white)
            }
        }
    }
}

#Preview{
    CategorySelector()
        .environmentObject(QuizManager())
}
