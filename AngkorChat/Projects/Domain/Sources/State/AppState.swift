//
//  AppState.swift
//  AngkorChat
//
//  Created by 강현준 on 11/2/24.
//  Copyright © 2024 clamp. All rights reserved.
//

import SwiftUI

@MainActor
public final class AppState: ObservableObject, Sendable {
    
    @Published public var isLoggedIn: Bool = false
    
    public static var shared: AppState = AppState()
    
    private init() { }
}
