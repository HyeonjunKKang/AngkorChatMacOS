//
//  SplashCoordinator.swift
//  SplashFeature
//
//  Created by 강현준 on 11/7/24.
//  Copyright © 2024 clamp. All rights reserved.
//

import Foundation
import Core
import SwiftUI

@objc public protocol SplashCoordinatorFinishDelegate: CoordinatorFinishDelegate {
    func splashDidFinish(_ coordinator: Coordinator)
}

public final class SplashCoordinator: BaseCoordinator {
    
    weak public var finishDelegate: SplashCoordinatorFinishDelegate?
    
    override public func start() {
        showSplash()
    }
    
    public override func finish() {
        super.finish()
        finishDelegate?.splashDidFinish(self)
    }
    
    private func showSplash() {
        let splashView = SplashView.build()
        let hostingController = NSHostingController(rootView: splashView)
        window.contentView = hostingController.view
        window.makeKeyAndOrderFront(nil)
    }
}
