//
//  MessageAppChatUIView.swift
//  SwiftUIForBlog
//
//  Created by 김민택 on 2/16/25.
//

import SwiftUI

struct MessageAppChatUIView: View {
    var group: String
    @Binding var messages: [MessageAppDataModel]

    var body: some View {
        ScrollView {
            ForEach(messages.filter { $0.messageGroup == group }, id: \.date) { message in
                HStack {
                    if message.sender == "Me" {
                        Spacer()
                        Text(message.message)
                            .foregroundStyle(.white)
                            .padding(8)
                            .background {
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundStyle(.blue)
                            }
                            .contextMenu {
                                Button(action: {}) {
                                    Label("답장", systemImage: "arrowshape.turn.up.backward")
                                }
                                Button(action: {}) {
                                    Label("스티커 추가", systemImage: "circle.badge.plus")
                                }
                                Section {
                                    Button(action: {}) {
                                        Label("복사", systemImage: "document.on.document")
                                    }
                                    Button(action: {}) {
                                        Label("번역", systemImage: "translate")
                                    }
                                    Button(action: {}) {
                                        Label("더 보기...", systemImage: "ellipsis.circle")
                                    }
                                }
                            }
                    } else {
                        Text(message.message)
                            .padding(8)
                            .background {
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundStyle(.gray)
                            }
                            .contextMenu {
                                Button(action: {}) {
                                    Label("답장", systemImage: "arrowshape.turn.up.backward")
                                }
                                Divider()
                                Button(action: {}) {
                                    Label("스티커 추가", systemImage: "circle.badge.plus")
                                }
                                Section {
                                    Button(action: {}) {
                                        Label("복사", systemImage: "document.on.document")
                                    }
                                    Button(action: {}) {
                                        Label("번역", systemImage: "translate")
                                    }
                                    Button(action: {}) {
                                        Label("더 보기...", systemImage: "ellipsis.circle")
                                    }
                                }
                            }
                        Spacer()
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .navigationTitle(group)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 48, height: 48)
                    .foregroundStyle(.gray)
            }
        }
    }
}

//#Preview {
//    MessageAppChatUIView()
//}

