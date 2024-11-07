//
//  Coordinator.swift
//  Core
//
//  Created by 강현준 on 11/4/24.
//  Copyright © 2024 clamp. All rights reserved.
//

import AppKit

@objc public protocol Coordinator: AnyObject {
    
    var id: String { get }
    
    var childCoordiantors: [String : Coordinator] { get set }
    
    var window: NSWindow { get set }
    
    @objc optional var finishDelegate: CoordinatorFinishDelegate? { get }
    
    func start()
    
    func finish()
}

public extension Coordinator {
    func addChild(_ child: Coordinator) {
        self.childCoordiantors[child.id] = child
    }
    
    func removeChild(_ child: Coordinator) {
        self.childCoordiantors[child.id] = nil
    }
}

@objc public protocol CoordinatorFinishDelegate: AnyObject {
    
}
