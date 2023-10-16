//
//  Extensions.swift
//  ogre
//
//  Created by Samujjwal Kumar on 10/15/23.
//

import Foundation
import SwiftUI

extension Text{
    func lilacTitle() -> some View{
        self.font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .fontWeight(.heavy)
            .foregroundColor(Color.accentColor)
    }
}
