//
//  Coordinator.swift
//  Core
//
//  Created by 강현준 on 11/4/24.
//  Copyright © 2024 clamp. All rights reserved.
//

import AppKit

public protocol Coordinator: AnyObject {
    
    var id: String { get }
    
    var childCoordiantors: [String : any Coordinator] { get set }
    
    var window: NSWindow { get set }
    
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    
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

public protocol CoordinatorFinishDelegate: AnyObject {
    
}
