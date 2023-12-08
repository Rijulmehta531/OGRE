//
//  PremiumLockedView.swift
//  ogre
//
//  Created by Rijul Mehta on 12/7/23.
//

import SwiftUI

struct PremiumLockedView: View {
    var body: some View {
        VStack{
            Spacer()
            Image(systemName: "exclamationmark.lock.fill")
                .resizable()
                .frame(width: 70,height: 90)
                .foregroundColor(Color.accentColor)
                
            
            Text("This content is locked!")
                .lilacTitle()
            Text("You need to be a Premium Member")
                .font(.custom("Optima-Bold", size: 22, relativeTo: .title2))
                .foregroundColor(Color.accentColor)
            Spacer()
        }
    }
}

#Preview {
    PremiumLockedView()
}
