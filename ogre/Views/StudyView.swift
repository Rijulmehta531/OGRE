//
//  StudyView.swift
//  ogre
//
//  Created by Brian Johnson on 11/4/23.
//

import SwiftUI

struct StudyView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Study 📚")
                .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                .frame(maxWidth: .infinity)
                .padding(.bottom, 16)
                .foregroundColor(.white)
                .background(.purple)
            ScrollView(.vertical, showsIndicators: false) {
                Spacer()
                General_CS()
                Spacer()
                VerbalReasoning_CS()
                Spacer()
                QuantitativeReasoning_CS()
                Spacer()
                AnalyticalWriting_CS()
                
                HStack{
                    Spacer()
                    
                }
                    }
            
            
        }
    }
}

#Preview {
    StudyView()
}
