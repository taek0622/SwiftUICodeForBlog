//
//  MessageAppGroupView.swift
//  SwiftUIForBlog
//
//  Created by 김민택 on 2/16/25.
//

import SwiftUI

struct MessageAppGroupUIView: View {
    @State private var service = MessageAppService()

    var body: some View {
        List(service.messageGroups, id: \.self) { group in
            NavigationLink {
                MessageAppChatUIView(group: group.messageGroup, messages: $service.messages)
            } label: {
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .foregroundStyle(.gray)
                    VStack {
                        HStack {
                            Text(group.messageGroup)
                                .foregroundStyle(.black)
                                .bold()
                            Spacer()
                            Text(group.date)
                                .foregroundStyle(.gray)
                        }
                        HStack {
                            Text(group.message)
                                .foregroundStyle(.gray)
                            Spacer()
                        }
                    }
                }
            }
            .contextMenu {
                Button(action: {}) {
                    Label("고정", systemImage: "pin")
                }
                Button(action: {}) {
                    Label("읽지 않음으로 표시", systemImage: "message.badge")
                }
                Button(action: {}) {
                    Label("알림 가리기", systemImage: "bell.slash")
                }
                Button(action: {}) {
                    Label("삭제", systemImage: "trash")
                }
            } preview: {
                MessageAppChatUIView(group: group.messageGroup, messages: $service.messages)
                    .frame(width: UIScreen.main.bounds.width - 32)
            }
        }
        .listStyle(.plain)
        .onAppear {
            service.fetchMessageGroup()
        }
    }
}

#Preview {
    MessageAppGroupUIView()
}
