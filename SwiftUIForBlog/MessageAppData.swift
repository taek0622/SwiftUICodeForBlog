//
//  MessageAppData.swift
//  SwiftUIForBlog
//
//  Created by 김민택 on 2/16/25.
//

import Foundation

struct MessageAppDataModel: Hashable {
    let messageGroup: String
    let sender: String
    let message: String
    let date: String
}

@Observable
class MessageAppService {
    var messages: [MessageAppDataModel] = [.init(messageGroup: "MJH", sender: "Me", message: "Happy Birthday", date: "2024-03-31 15:00:02.123"), .init(messageGroup: "MJH", sender: "MJH", message: "Thanks", date: "2024-03-31 15:01:07.537"), .init(messageGroup: "LJH", sender: "Me", message: "Hi", date: "2024-09-11 21:11:32.157"), .init(messageGroup: "LJH", sender: "LJH", message: "Oh, Hi", date: "2024-09-11 21:13:27.812")]
    var messageGroups = [MessageAppDataModel]()

    func fetchMessageGroup() {
        messageGroups = []
        var groups = [String: MessageAppDataModel]()

        messages.forEach { message in
            groups[message.messageGroup] = message
        }

        groups.values.sorted { $0.date > $1.date }.forEach {
            messageGroups.append($0)
        }
    }
}
