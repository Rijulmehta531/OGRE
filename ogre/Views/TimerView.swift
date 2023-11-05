//
//  TimerView.swift
//  ogre
//
//  Created by Samujjwal Kumar on 10/31/23.
//

import SwiftUI

struct TimerView: View {
    @Binding var timeRemaining: Int
    
    

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 4)
                .opacity(0.3)
                .foregroundColor(Color.gray)

            Circle()
                .trim(from: 0.0, to: CGFloat(timeRemaining) / 20.0)  // Same as time remaining
                .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.red)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)

            Text("\(timeRemaining)")
                .font(.title)
                .bold()
        }
        .frame(width: 50, height: 50)

        
    }
}

