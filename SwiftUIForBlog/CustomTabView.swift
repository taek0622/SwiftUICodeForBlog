//
//  CustomTabView.swift
//  SwiftUIForBlog
//
//  Created by 김민택 on 7/23/24.
//

import SwiftUI

struct CustomTabView: View {
    enum Tab {
        case first, second, third
    }

    @State private var selected: Tab = .first

    var body: some View {
        ZStack {
            TabView(selection: $selected) {
                Group {
                    CTFirstView()
                        .tag(Tab.first)
                    CTSecondView()
                        .tag(Tab.second)
                    CTThirdView()
                        .tag(Tab.third)
                }
//                    .toolbar(.hidden, for: .tabBar)
            }

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        selected = .first
                    } label: {
                        VStack {
                            Image(systemName: selected == .first ? "house.fill": "house")
                            Text("first")
                                .font(.system(size: 14))
                        }
                            .foregroundStyle(selected == .first ? Color.blue : Color.black)
                    }
                    Spacer()
                    Button {
                        selected = .second
                    } label: {
                        VStack {
                            Image(systemName: selected == .second ? "folder.fill": "folder")
                            Text("second")
                                .font(.system(size: 14))
                        }
                            .foregroundStyle(selected == .second ? Color.blue : Color.black)
                    }
                    Spacer()
                    Button {
                        selected = .third
                    } label: {
                        VStack {
                            Image(systemName: selected == .third ? "gearshape.fill": "gearshape")
                            Text("third")
                                .font(.system(size: 14))
                        }
                            .foregroundStyle(selected == .third ? Color.blue : Color.black)
                    }
                    Spacer()
                }
                .padding(8)
                .background {
                    RoundedRectangle(cornerRadius: 32)
                        .fill(.white)
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

struct CTFirstView: View {
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            Text("First")
        }
    }
}

struct CTSecondView: View {
    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()
            Text("Second")
        }
    }
}

struct CTThirdView: View {
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            Text("Third")
        }
    }
}

#Preview {
    CustomTabView()
}
