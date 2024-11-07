//
//  BaseCoordinator.swift
//  Core
//
//  Created by 강현준 on 11/7/24.
//  Copyright © 2024 clamp. All rights reserved.
//

import AppKit

open class BaseCoordinator: Coordinator {
    
    public var window: NSWindow
    
    public var id: String = UUID().uuidString
    
    public var childCoordiantors: [String : Coordinator] = [:]
    
    public init(window: NSWindow) {
        self.window = window
    }
    
    open func start() {
        
    }
    
    open func finish() {
        childCoordiantors.removeAll()
    }
}
