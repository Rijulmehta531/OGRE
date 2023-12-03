//
//  General_CS.swift
//  ogre
//
//  Created by Brian Johnson on 11/5/23.
//

import SwiftUI
import UIKit

struct General_CS: View {
    var body: some View {
        
        VStack {
            Text("")
                .foregroundColor(.purple)
                .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    GCategorySelector(
                        categoryName: "General GRE Test \nStrategies/Tips",
                        categoryDescription: "",
                        categoryIcon: ""
                    )
                    GCategorySelector(
                        categoryName: "Community Upload",
                        categoryDescription: "Upload notes and other study resources",
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

struct GCategorySelector: View {
    let categoryName: String
    let categoryDescription: String
    let categoryIcon: String
    @State private var categorySelected = false
    @State var isCUploadPresented = false
    
    var body: some View {
        Button(action: {
            if(categoryName == "General GRE Test \nStrategies/Tips") {
                if let url = URL(string: "https://www.ets.org/gre/test-takers/general-test/prepare/strategies-tips.html") {
                    UIApplication.shared.open(url)
                }
            } else {
                isCUploadPresented = true
            }
                }) {
                    ZStack() {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(.purple)
                            .frame(width: 300, height: 300)
                        VStack {
                            Text(categoryName)
                                .font(.custom("Optima-ExtraBlack", size: 25, relativeTo: .title2))
                                
                        }
                        .foregroundColor(.white)
                    }
                }
                .popover(isPresented: $isCUploadPresented) {
                    VStack(alignment: .leading) {
                        Text("\nCommunity Upload")
                            .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 16)
                            .foregroundColor(.white)
                            .background(.purple)
                        Spacer()
                    }
                }
            
        }
    }




#Preview {
    General_CS()
}
