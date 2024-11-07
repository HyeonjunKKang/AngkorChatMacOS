//
//  AngkorChatApp.swift
//  AngkorChat
//
//  Created by 강현준 on 11/1/24.
//  Copyright © 2024 clamp. All rights reserved.
//

import Cocoa
import Core
import RootFeature

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var rootCoordinator: RootCoordinator?
    
    static func main() {
        let app = NSApplication.shared
        let delegate = AppDelegate()
        app.delegate = delegate
        app.run()
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let window = BaseWindow()
        rootCoordinator = RootCoordinator(window: window)
        rootCoordinator?.start()
    }
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        print("applicationWillFinishLaunching")
    }
}
