//
//  Protocol.swift
//  SplashFeature
//
//  Created by 강현준 on 11/7/24.
//  Copyright © 2024 clamp. All rights reserved.
//

import Foundation
import Core

protocol SplashModelStateProtocol {
    var userID: String { get }
    var password: String { get }
    var loginBtnEnable: Bool { get }
}

protocol SplashModelActionProtocol: AnyObject {
    func changedUserID(changed: String)
    func changedPassword(changed: String)
    func login()
}

protocol SplashIntentProtocol {
    func loginDidTap()
    func changedUserID(changed: String)
    func changedPassword(changed: String)
}
