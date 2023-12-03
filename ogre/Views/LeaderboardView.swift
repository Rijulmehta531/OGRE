//
//  LeaderboardView.swift
//  OGRE Prototype
//
//  Created by Brian Johnson on 10/11/23.
//

import SwiftUI
struct LeaderboardEntry: Identifiable {
    let id = UUID()
    let place: Int
    let name: String
    let points: Int
}

struct LeaderboardView: View {
    @State private var daysRemaining = 5
    private let targetWeekday = 2 // monday
    private let leaderboardData: [LeaderboardEntry] = [
        LeaderboardEntry(place: 1, name: "Row 1", points: 500),
        LeaderboardEntry(place: 2, name: "Row 2", points: 350),
        LeaderboardEntry(place: 3, name: "Row 3", points: 100),
        LeaderboardEntry(place: 4, name: "Row 4", points: 80)
            
        ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Leaderboard 🏆")
                .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                .frame(maxWidth: .infinity)
                .padding(.bottom, 16)
                .foregroundColor(.white)
                .background(.purple)
            Text("The next leaderboard begins soon:")
                .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                .frame(maxWidth: .infinity)
                .foregroundColor(.purple)
            if daysRemaining > 1 {
                Text("\(daysRemaining) days")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 16)
                    .foregroundColor(getTextColor())
                    .onAppear {
                        calculateDaysUntilMonday()
                    }
                Spacer()
            } else {
                Text("\(daysRemaining) day")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 16)
                    .foregroundColor(getTextColor())
                    .onAppear {
                        calculateDaysUntilMonday()
                    }
                Spacer()
            }
            List {
                ForEach(leaderboardData) { entry in
                    HStack {
                        if entry.place == 1 {
                            Text("🥇")
                                .frame(width: 50)
                                .font(.system(size: 40, weight: .bold))
                            Text(entry.name)
                                .frame(height: 50)
                                .font(.system(size: 20, weight: .bold))
                            Text("\(entry.points) Points")
                                .font(.system(size: 15, weight: .bold))
                                .frame(width: 150, alignment: .trailing)
                            
                        } else if entry.place == 2 {
                            Text("🥈")
                                .frame(width: 50)
                                .font(.system(size: 40, weight: .bold))
                            Text(entry.name)
                                .frame(height: 50)
                                .font(.system(size: 20, weight: .bold))
                            Text("\(entry.points) Points")
                                .font(.system(size: 15, weight: .bold))
                                .frame(width: 150, alignment: .trailing)
                        } else if entry.place == 3 {
                            Text("🥉")
                                .frame(width: 50)
                                .font(.system(size: 40, weight: .bold))
                            Text(entry.name)
                                .frame(height: 50)
                                .font(.system(size: 20, weight: .bold))
                            Text("\(entry.points) Points")
                                .font(.system(size: 15, weight: .bold))
                                .frame(width: 150, alignment: .trailing)
                        } else {
                            Text("\(entry.place)")
                                .frame(width: 50)
                                .font(.system(size: 20, weight: .bold))
                            Text(entry.name)
                                .frame(height: 50)
                                .font(.system(size: 20, weight: .bold))
                            Text("\(entry.points) Points")
                                .font(.system(size: 15, weight: .bold))
                                .frame(width: 150, alignment: .trailing)
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
    }
    //gets daysRemaining until monday
    private func calculateDaysUntilMonday() {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentWeekday = calendar.component(.weekday, from: currentDate)
                
        var daysToAdd = targetWeekday - currentWeekday
        if daysToAdd <= 0 {
            daysToAdd += 7 // add 7 days to get to the next monday
        }
        if let nextMonday = calendar.date(byAdding: .day, value: daysToAdd, to: currentDate) {
            let components = calendar.dateComponents([.day], from: currentDate, to: nextMonday)
            if let days = components.day {
                daysRemaining = days
            }
        }
    }
    //changes text color as it gets closer to monday
    private func getTextColor() -> Color {
        let maxDays = 7.0
        let daysPercentage = Double(daysRemaining) / maxDays
        
        let red = min(1.0, 2.0 - daysPercentage * 2.0)
        let green = min(1.0, daysPercentage * 2.0)
        
        return Color(red: red, green: green, blue: 0.0)
    }
}

#Preview {
    LeaderboardView()
}
