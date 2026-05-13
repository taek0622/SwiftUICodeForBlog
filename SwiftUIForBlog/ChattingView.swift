//
//  ChattingView.swift
//  SwiftUIForBlog
//
//  Created by 김민택 on 6/28/24.
//

import SwiftUI

struct Chat: Codable {
    var messageID: String?
    var userID: String
    var message: String
    var date: String?
}

struct ChattingView: View {
    @State private var chats = [Chat]() {
        didSet {
            webSocketService.receiveChat { chat in
                chats.append(chat)
            }
        }
    }
    @State private var sendingText = ""
    let webSocketService = WebSocketService.shared

    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(chats, id: \.messageID) { chat in
                        if chat.userID == "SystemMessage" {
                            Text(chat.message)
                                .font(.system(size: 14))
                                .padding(4)
                        } else if chat.userID == "\(webSocketService.myID)" {
                            HStack {
                                Spacer()
                                Text(chat.message)
                                    .foregroundStyle(.white)
                                    .padding(8)
                                    .background(.blue)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                        } else {
                            HStack {
                                Text(chat.message)
                                    .padding(8)
                                    .background(.gray)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                Spacer()
                            }
                        }
                    }
                }
                .padding(16)
            }
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                }
                TextField("전송할 메시지를 입력해주세요", text: $sendingText)
                    .textFieldStyle(.roundedBorder)
                Button {
                    let sendingChat = Chat(userID: "\(webSocketService.myID)", message: sendingText)
                    chats.append(sendingChat)
                    webSocketService.sendChat(chat: sendingChat)
                    sendingText = ""
                } label: {
                    Image(systemName: "arrow.up.circle")
                }
                .disabled(sendingText == "")
            }
            .padding(.horizontal, 16)
            .border(.gray)
        }
        .onAppear {
            webSocketService.openWebSocket()
            webSocketService.receiveChat { chat in
                chats.append(chat)
            }
        }
    }
}

class WebSocketService {
    private var url: URL
    private let session = URLSession(configuration: .default)
    private var webSocket: URLSessionWebSocketTask
    let myID = UUID()
    static let shared = WebSocketService()

    private init() {
        guard let url = URL(string: "ws://localhost:3000/chat") else { fatalError() }
        self.url = url
        self.webSocket = session.webSocketTask(with: url)
    }

    func openWebSocket() {
        webSocket.resume()
    }

    func sendChat(chat: Chat) {
        do {
            let data = try JSONEncoder().encode(chat)
            webSocket.send(.data(data)) { error in
                if let error { print("Sending Error") }
            }
        } catch {
            print("Encoding Error")
        }
    }

    func receiveChat(completion: @escaping (Chat) -> Void) {
        webSocket.receive { result in
            switch result {
            case .success(let chat):
                switch chat {
                case .data(let data):
                    print(data.description)
                case .string(let chatString):
                    let jsonData = chatString.data(using: .utf8)

                    do {
                        let chatData = try JSONDecoder().decode(Chat.self, from: jsonData!)
                        completion(chatData)
                    } catch {
                        print("Decoding Error")
                    }
                @unknown default:
                    print("Need new case")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ChattingView()
}
