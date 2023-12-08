//
//  LeaderboardView.swift
//  OGRE Prototype
//
//  Created by Brian Johnson on 10/11/23.
//

import SwiftUI

struct LeaderboardView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Leaderboard 🏆")
                .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                .frame(maxWidth: .infinity)
                .padding(.bottom, 16)
                .foregroundColor(.white)
            .background(.purple)
            Spacer()
        }
    }
}

#Preview {
    LeaderboardView()
}
