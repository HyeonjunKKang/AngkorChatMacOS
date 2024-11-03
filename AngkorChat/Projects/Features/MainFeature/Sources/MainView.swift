//
//  MainView.swift
//  AngkorChat
//
//  Created by 강현준 on 11/2/24.
//  Copyright © 2024 clamp. All rights reserved.
//

import Foundation
import SwiftUI

public struct MainView: View {
    @State private var selectedTab: Tab = .friends

    public var body: some View {
        NavigationView {
            Sidebar(selectedTab: $selectedTab)
            MainContentView(selectedTab: $selectedTab)
        }
    }
    
    public init() {
        
    }
}

enum Tab {
    case friends, chats, settings
}

public struct Sidebar: View {
    @Binding var selectedTab: Tab

    public var body: some View {
        VStack {
            Button(action: { selectedTab = .friends }) {
                Label("친구", systemImage: "person")
            }
            .padding()

            Button(action: { selectedTab = .chats }) {
                Label("채팅", systemImage: "bubble.left.and.bubble.right")
            }
            .padding()

            Button(action: { selectedTab = .settings }) {
                Label("설정", systemImage: "gearshape")
            }
            .padding()
            
            Spacer()
        }
        .frame(maxWidth: 100)
        .background(Color.gray.opacity(0.1))
    }
}

struct MainContentView: View {
    @Binding var selectedTab: Tab

    var body: some View {
        switch selectedTab {
        case .friends:
            FriendsView()
        case .chats:
            ChatsView()
        case .settings:
            SettingsView()
        }
    }
}

struct FriendsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("친구")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom)

                // 프로필 섹션
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("현준")
                            .font(.title2)
                        Text("상태 메시지")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding()

                Divider()

                // 업데이트한 프로필 섹션
                VStack(alignment: .leading) {
                    Text("업데이트한 프로필")
                        .font(.headline)
                        .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(0..<5, id: \.self) { _ in
                                VStack {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("이름")
                                        .font(.caption)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }

                Divider()

                // 생일인 친구 섹션
                VStack(alignment: .leading) {
                    Text("생일인 친구")
                        .font(.headline)
                        .padding(.horizontal)
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                        VStack(alignment: .leading) {
                            Text("친구 이름")
                                .font(.subheadline)
                            Text("생일 날짜")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Button(action: {}) {
                            Text("선물하기")
                        }
                    }
                    .padding(.horizontal)
                }

                Divider()

                // 즐겨찾기
                VStack(alignment: .leading) {
                    Text("즐겨찾기")
                        .font(.headline)
                        .padding(.horizontal)
                    HStack {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                        VStack(alignment: .leading) {
                            Text("삼성청년SW아카데미")
                                .font(.subheadline)
                            Text("대한민국 SW의 미래를...")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                }

                Divider()

                // 친구 목록 섹션
                VStack(alignment: .leading) {
                    Text("친구 586")
                        .font(.headline)
                        .padding(.horizontal)
                    ForEach(0..<10, id: \.self) { _ in
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                            VStack(alignment: .leading) {
                                Text("친구 이름")
                                    .font(.subheadline)
                                Text("상태 메시지")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding()
        }
    }
}

struct ChatsView: View {
    var body: some View {
        Text("채팅 화면")
            .font(.largeTitle)
    }
}

struct SettingsView: View {
    var body: some View {
        Text("설정 화면")
            .font(.largeTitle)
    }
}

#Preview {
    MainView()
}
