//
//  MainMenuView.swift
//  OGRE Prototype
//
//  Created by Brian Johnson on 10/10/23.
//

import SwiftUI
let name = "Rao"
struct MainMenuView: View {
    @State private var selectedTab: Tab = .house
    @State private var VRButtonTapped = false
    @State private var QRButtonTapped = false
    @State private var AWButtonTapped = false
    @State private var ALLButtonTapped = false
  
    @State private var itemsFA: [Item] = [
        .init(buttonEmoji: "🗣️", title: "Verbal Reasoning", selectedTitle: "Verbal Reasoning: ✅", subTitle: "Analyze and evaluate written material", isTapped : false),
        .init(buttonEmoji: "🔢", title: "Quantitative Reasoning", selectedTitle: "Quantitative Reasoning: ✅", subTitle: "Basic mathematical skills",isTapped : false),
        .init(buttonEmoji: "📝", title: "Analytical Writing", selectedTitle: "Analytical Writing: ✅", subTitle: "Assesses your critcal thinking and analytical writing skills",isTapped : false),
        .init(buttonEmoji: "🗣️🔢📝", title: "All Areas", selectedTitle: "All Areas: ✅", subTitle: "All 3 areas, all at once!",isTapped : false)
    
    ]
    
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack {
            VStack {
                TabView(selection: $selectedTab) {
                    if selectedTab == Tab.house {
                        VStack(alignment: .leading) {
                            Text("Welcome, \(name)! 👋")
                                .font(.largeTitle)
                                .padding(.leading)
                                .fontWeight(.bold)
                                .foregroundColor(Color.purple)
                                .padding(.bottom, 20)
                                Text("Choose an OGRE Focus Area")
                                    .padding(.leading)
                                    .font(.title)
                                    .foregroundColor(Color.purple)
                                    
                            PagingSlider(data: $itemsFA) { $item in
                                Button(action: {
                                    item.isTapped.toggle()
                                    
                                }) {
                                    Text(item.buttonEmoji)
                                        .font(.system(size: 100))
                                
                            }
                                
                            } titleContent: { $item in
                                VStack(spacing: 5) {
                                    if item.isTapped {
                                        Text(item.selectedTitle)
                                            .font(.title2.bold())
                                            .foregroundColor(Color.purple)
                                        
                                        Text(item.subTitle)
                                            .foregroundStyle(.purple)
                                            .multilineTextAlignment(.center)
                                    } else {
                                        Text(item.title)
                                            .font(.title2.bold())
                                            .foregroundColor(Color.purple)
                                        
                                        Text(item.subTitle)
                                            .foregroundStyle(.purple)
                                            .multilineTextAlignment(.center)
                                    }
                                    
                                        
                                }
                                .padding(.bottom)
                            }
                            .safeAreaPadding([.horizontal, .top],1)

                            Text("Customize Your Quiz")
                                .padding()
                                .font(.title)
                                .foregroundColor(Color.purple)
                            Spacer()
                            
                        }
                    } else if selectedTab == Tab.book {
                        Text("Study Materials Under Construction")
                    } else if selectedTab == Tab.gearshape {
                        Text("Settings Under Construction")
                    } else if selectedTab == Tab.person {
                        Text("Profile Under Construction")
                    } else {
                        Text("Leaderboard Under Construction")
                    }
                                
                    
                        
                }
            }
            VStack {
                Spacer()
                TabBar(selectedTab: $selectedTab)
            }
        }
        
        
        
    }
    
    
}

#Preview {
    MainMenuView()
}
