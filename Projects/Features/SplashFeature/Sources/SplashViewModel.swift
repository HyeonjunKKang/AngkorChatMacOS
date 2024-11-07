//
//  SplashViewModel.swift
//  SplashFeature
//
//  Created by 강현준 on 11/2/24.
//  Copyright © 2024 clamp. All rights reserved.
//

import Foundation

enum SplashViewResult {
    
}

public final class SplashViewModel: ObservableObject {
    
    @MainActor public var id: String = ""
    @MainActor public var password: String = ""
    
    public init() {}
    
    public func login() {
        
    }
}
