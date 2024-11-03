//
//  AngkorChatApp.swift
//  AngkorChat
//
//  Created by 강현준 on 11/1/24.
//  Copyright © 2024 clamp. All rights reserved.
//

import SwiftUI
import SplashFeature
import MainFeature
import Domain

@main
struct AngkorChatApp: App {
    
    @StateObject var appState: AppState = AppState.shared
    
    var body: some Scene {
        WindowGroup {
            if !appState.isLoggedIn {
                SplashView()
                    .environmentObject(appState)
            } else {
                MainView()
            }
        }
    }
}
