//
//  BarMarkXYInterval.swift
//  SwiftUIForBlog
//
//  Created by 김민택 on 2023/03/26.
//

import Charts
import SwiftUI

struct MusicPlayTime: Identifiable {
    let title: String
    let start: Int
    let end: Int
    let id = UUID()
}

struct BarMarkXYInterval: View {
    var data: [MusicPlayTime] = [
        MusicPlayTime(title: "비밀", start: 0, end: 40),
        MusicPlayTime(title: "블루밍", start: 30, end: 60),
        MusicPlayTime(title: "정거장", start: 20, end: 50),
        MusicPlayTime(title: "비밀", start: 80, end: 120),
        MusicPlayTime(title: "블루밍", start: 100, end: 140),
        MusicPlayTime(title: "비밀", start: 160, end: 170),
        MusicPlayTime(title: "블루밍", start: 150, end: 200),
        MusicPlayTime(title: "정거장", start: 180, end: 200)
    ]

    var body: some View {
        Chart(data) {
//            BarMark(
//                xStart: .value("Start Time", $0.start),
//                xEnd: .value("End Time", $0.end),
//                y: .value("제목", $0.title)
//            )
//            BarMark(
//                yStart: .value("Start Time", $0.start),
//                yEnd: .value("End Time", $0.end)
//            )
            BarMark(
                xStart: .value("Start Time", $0.start),
                xEnd: .value("End Time", $0.end),
                yStart: 300,
                yEnd: 400
            )
//            BarMark(
//                x: .value("제목", $0.title),
//                yStart: .value("Start Time", $0.start),
//                yEnd: .value("End Time", $0.end)
//            )
        }
    }
}

//struct BarMarkXYInterval_Previews: PreviewProvider {
//    static var previews: some View {
//        BarMarkXYInterval()
//    }
//}
