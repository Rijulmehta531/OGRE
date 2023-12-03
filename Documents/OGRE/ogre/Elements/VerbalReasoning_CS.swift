//
//  VerbalReasoning_CS.swift
//  ogre
//
//  Created by Brian Johnson on 11/5/23.
//

import SwiftUI

struct VerbalReasoning_CS: View {
    var body: some View {
        VStack {
            Text("Verbal Reasoning")
                .foregroundColor(.purple)
                .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    VerbalReasoningCategorySelector(
                        categoryName: "Strategies/Tips",
                        categoryDescription: "",
                        categoryIcon: ""
                    )
                    VerbalReasoningCategorySelector(
                        categoryName: "Reading\nComprehension",
                        categoryDescription: "",
                        categoryIcon: ""
                    )
                    VerbalReasoningCategorySelector(
                        categoryName: "Text Completion",
                        categoryDescription: "",
                        categoryIcon: ""
                    )
                    VerbalReasoningCategorySelector(
                        categoryName: "Sentence Equivalence",
                        categoryDescription: "",
                        categoryIcon: ""
                    )
                    
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .safeAreaPadding(.horizontal, 44)
        }
        .frame(height: 360)
    }
}

struct VerbalReasoningCategorySelector: View {
    let categoryName: String
    let categoryDescription: String
    let categoryIcon: String
    @State private var categorySelected = false
    
    var body: some View {
        Button(action: {
            if(categoryName == "Strategies/Tips") {
                if let url = URL(string: "https://www.ets.org/gre/test-takers/general-test/prepare/content/verbal-reasoning.html") {
                    UIApplication.shared.open(url)
                }
            } else if(categoryName == "Reading\nComprehension") {
                if let url = URL(string: "https://www.ets.org/gre/test-takers/general-test/prepare/content/verbal-reasoning.html#accordion-9f58105fc6-item-d0162f9786") {
                    UIApplication.shared.open(url)
                }
            } else if(categoryName == "Text Completion") {
                if let url = URL(string: "https://www.ets.org/gre/test-takers/general-test/prepare/content/verbal-reasoning.html#accordion-9f58105fc6-item-88093eca37") {
                    UIApplication.shared.open(url)
                }
            } else if(categoryName == "Sentence Equivalence") {
                if let url = URL(string: "https://www.ets.org/gre/test-takers/general-test/prepare/content/verbal-reasoning.html#accordion-9f58105fc6-item-3038780b34") {
                    UIApplication.shared.open(url)
                }
            }
        }) {
            ZStack() {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(categorySelected ? .green : .purple)
                    .frame(width: 300, height: 300)
                VStack {
                    Text(categoryName)
                        .font(.custom("Optima-ExtraBlack", size: 25, relativeTo: .title2))
                        
                }
                .foregroundColor(.white)
            }
        }
    }
}


#Preview {
    VerbalReasoning_CS()
}
