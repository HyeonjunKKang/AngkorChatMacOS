//
//  RootCoordinator.swift
//  Root
//
//  Created by 강현준 on 11/4/24.
//  Copyright © 2024 clamp. All rights reserved.
//

import Core
import AppKit
import SplashFeature
import MainFeature

public final class RootCoordinator: BaseCoordinator {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    public override func start() {
        startSplash()
    }
    
    func startSplash() {
        let coordinator = SplashCoordinator(window: self.window)
        coordinator.finishDelegate = self
        addChild(coordinator)
        coordinator.start()
    }
    
    func startMain() {
        let coordinator = MainCoordinator(window: self.window)
        addChild(coordinator)
        coordinator.start()
    }
}

extension RootCoordinator: SplashCoordinatorFinishDelegate {
    public func splashDidFinish(_ coordinator: Coordinator) {
        startMain()
        removeChild(coordinator)
    }
}
