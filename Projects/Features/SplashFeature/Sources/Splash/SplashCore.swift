//
//  SplashCore.swift
//  SplashFeature
//
//  Created by 강현준 on 11/7/24.
//  Copyright © 2024 clamp. All rights reserved.
//

import Foundation
import Core

final class SplashModel: ObservableObject, SplashModelStateProtocol {
    @Published var userID: String = ""
    @Published var password: String = ""
    @Published var loginBtnEnable: Bool = false
}

extension SplashModel: SplashModelActionProtocol {
    func changedUserID(changed: String) {
        self.userID = changed
        checkLoginBtnEnable()
    }
    
    func changedPassword(changed: String) {
        self.password = changed
        checkLoginBtnEnable()
    }
    
    func login() {
        print("로그이이이인!!!!!")
    }
    
    func checkLoginBtnEnable() {
        loginBtnEnable = !userID.isEmpty && !password.isEmpty
    }
}

final class SplashIntent {
    private weak var model: SplashModelActionProtocol?
    
    init(model: SplashModelActionProtocol) {
        self.model = model
    }
}

extension SplashIntent: SplashIntentProtocol {
    func loginDidTap() {
        model?.login()
    }
    
    func changedUserID(changed: String) {
        model?.changedUserID(changed: changed)
    }
    
    func changedPassword(changed: String) {
        model?.changedPassword(changed: changed)
    }
}
