//
//  SplashView.swift
//  AngkorChat
//
//  Created by 강현준 on 11/1/24.
//  Copyright © 2024 clamp. All rights reserved.
//

import SwiftUI
import Core

public struct SplashView: View {
    
    @StateObject var container: MVIContainer<SplashIntentProtocol, SplashModelStateProtocol>
    private var state: SplashModelStateProtocol { container.model }
    private var intent: SplashIntentProtocol { container.intent }
    
    init(container: MVIContainer<SplashIntentProtocol, SplashModelStateProtocol>) {
        self._container = StateObject(wrappedValue: container)
    }
    
    public var body: some View {
        
        ZStack {
            
            Color.white
            
            VStack(spacing: 0) {
                
                Spacer()
                
                Text("AngkorChat")
                    .font(.system(size: 45))
                
                Spacer()
                    .frame(height: 20)
                
                Group {
                    TextField(
                        "아이디",
                        text: Binding(
                            get: { return state.userID },
                            set: { intent.changedUserID(changed: $0) }
                        )
                    )
                    SecureField(
                        "비밀번호",
                        text: Binding(
                            get: { return state.password },
                            set: { intent.changedPassword(changed: $0) }
                        )
                    )
                        
                }
                .frame(width: 250)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()
                    .frame(height: 20)
                
                Button(
                    action: {
                        intent.loginDidTap()
                    },
                    label: {
                        Text("로그인")
                    }
                )
                .disabled(!state.loginBtnEnable)
                
                Spacer()
            }
            .padding()
        }
    }
}

extension SplashView {
    static func build() -> some View {
        let model = SplashModel()
        let intent = SplashIntent(model: model)
        let container = MVIContainer(
            intent: intent as SplashIntentProtocol,
            model: model as SplashModelStateProtocol,
            modelChangePublisher: model.objectWillChange
        )
        
        let view = SplashView(container: container)
        return view
    }
}
