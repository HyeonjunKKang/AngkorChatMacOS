//
//  SplashView.swift
//  AngkorChat
//
//  Created by 강현준 on 11/1/24.
//  Copyright © 2024 clamp. All rights reserved.
//

import SwiftUI

public struct SplashView: View {
    
    @State private var userID: String = ""
    @State private var password: String = ""
    
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
                    TextField("아이디", text: $userID)
                        
                    SecureField("비밀번호", text: $password)
                        
                }
                .frame(width: 250)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()
                    .frame(height: 20)
                
                Button(
                    action: {
                        
                    },
                    label: {
                        Text("로그인")
                    }
                )
                
                Spacer()
            }
            .padding()
        }
    }
    
    public init(){}
}

#Preview {
    SplashView()
}
