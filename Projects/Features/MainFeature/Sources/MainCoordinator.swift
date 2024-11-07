//
//  MainCoordinator.swift
//  MainFeature
//
//  Created by 강현준 on 11/7/24.
//  Copyright © 2024 clamp. All rights reserved.
//

import Foundation
import Core
import SwiftUI

public final class MainCoordinator: BaseCoordinator {
    public override func start() {
        showMain()
    }
    
    private func showMain() {
        let mainView = MainView()
        let hostingController = NSHostingController(rootView: mainView)
        window.contentView = hostingController.view
        window.makeKey()
    }
}
