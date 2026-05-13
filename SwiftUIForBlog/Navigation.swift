//
//  Navigation.swift
//  SwiftUIForBlog
//
//  Created by 김민택 on 5/12/25.
//

import SwiftUI

struct NavigationTypeView: View {
    var body: some View {
        List {
            NavigationLink("탭 바", destination: TabBarView())
            NavigationLink("네비게이션 스택 + 패스", destination: NavigationPathView())
        }
    }
}

struct TabBarView: View {
    var body: some View {
        TabView {
            ZStack {
                Color.yellow
                Text("첫 번째 뷰 입니다.")
            }
            .tabItem { Label("뷰 1", systemImage: "star") }

            ZStack {
                Color.pink
                Text("두 번째 뷰 입니다.")
            }
            .tabItem { Label("뷰 2", systemImage: "heart") }

            ZStack {
                Color.green
                Text("세 번째 뷰 입니다.")
            }
            .tabItem { Label("뷰 3", systemImage: "leaf") }
        }
    }
}

struct NavigationPathView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            Button("다음 뷰로 이동") {
                path.append("Next")
            }
            .navigationDestination(for: String.self) { string in
                if string == "Next" {
                    NavigationPathMiddleView(path: $path)
                } else if string == "End" {
                    NavigationPathEndView(path: $path)
                } else {
                    VStack {
                        Color.red
                    }
                }
            }
        }
        .navigationTitle("패스 시작")
    }
}

struct NavigationPathMiddleView: View {
    @Binding var path: NavigationPath

    var body: some View {
        VStack {
            Button("마지막 뷰로 이동") {
                path.append("End")
            }
        }
        .navigationTitle("패스 중간")
    }
}

struct NavigationPathEndView: View {
    @Binding var path: NavigationPath

    var body: some View {
        VStack {
            Button("처음 뷰로 돌아가기") {
                path = .init()
            }
//            NavigationLink("처음 뷰로 돌아가기", value: "Init")
//                .navigationDestination(for: String.self) { _ in
//                    NavigationPathView()
//                }
        }
        .navigationTitle("패스 마지막")
    }
}
