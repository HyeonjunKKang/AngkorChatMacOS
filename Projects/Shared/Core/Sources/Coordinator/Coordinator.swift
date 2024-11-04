//
//  Coordinator.swift
//  Core
//
//  Created by 강현준 on 11/4/24.
//  Copyright © 2024 clamp. All rights reserved.
//

import AppKit
import SwiftUI

public protocol Coordinator: AnyObject {
    
    let adfsa = NavigationStack
    
    var childCoordiantors: [Coordinator] { get set }
    
    var mainViewController: NSViewController { get }
    
    func start()
    
    func addChild(_ coordinator: Coordinator)
    
    func removeChild(_ coordinator: Coordinator)
    
}

extension Coordinator {
    func addChild(_ coordinator: Coordinator) {
        childCoordiantors.append(coordinator)
    }
    
    func removechild(_ coordinator: Coordinator) {
        childCoordiantors.removeAll(where: { $0 === coordinator })
    }
}
