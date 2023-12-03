//
//  AnalyticalWriting_CS.swift
//  ogre
//
//  Created by Brian Johnson on 11/5/23.
//

import SwiftUI

struct AnalyticalWriting_CS: View {
    var body: some View {
        VStack {
            Text("Analytical Writing")
                .foregroundColor(.purple)
                .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    AnalyticalWritingCategorySelector(
                        categoryName: "Strategies/Tips",
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

struct AnalyticalWritingCategorySelector: View {
    let categoryName: String
    let categoryDescription: String
    let categoryIcon: String
    @State private var categorySelected = false
    
    var body: some View {
        Button(action: {
            if let url = URL(string: "https://www.ets.org/gre/test-takers/general-test/prepare/content/analytical-writing.html") {
                            UIApplication.shared.open(url)
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
    AnalyticalWriting_CS()
}
