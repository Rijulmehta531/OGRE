//
//  SettingsView.swift
//  ogre
//
//  Created by Brian Johnson on 11/19/23.
//

import SwiftUI

struct SettingsView: View {
    @State var isSoundEnabled = true
    var body: some View {
        VStack{
            Text("Settings")
                .lilacTitle()
            List{
                Toggle(isOn: $isSoundEnabled) {
                    Text("Sounds")
                }
                .onReceive([self.isSoundEnabled].publisher.first()) { value in
                    SoundManager.isSoundEnabled = value
                }
            }}
    }
}

#Preview {
    SettingsView()
}
