//
//  BarChart.swift
//  SwiftUIForBlog
//
//  Created by 김민택 on 2023/02/26.
//

import Charts
import SwiftUI

struct Toy: Identifiable {
    var color: String
    var type: String
    var count: Double
    var id = UUID()
}

struct BarChart: View {
    var data: [Toy] = [
        .init(color: "초록색", type: "정육면체", count: 2),
        .init(color: "초록색", type: "구", count: 0),
        .init(color: "초록색", type: "피라미드", count: 1),
        .init(color: "보라색", type: "정육면체", count: 1),
        .init(color: "보라색", type: "구", count: 1),
        .init(color: "보라색", type: "피라미드", count: 1),
        .init(color: "분홍색", type: "정육면체", count: 1),
        .init(color: "분홍색", type: "구", count: 2),
        .init(color: "분홍색", type: "피라미드", count: 0),
        .init(color: "노랑색", type: "정육면체", count: 1),
        .init(color: "노랑색", type: "구", count: 1),
        .init(color: "노랑색", type: "피라미드", count: 2)
    ]

    var body: some View {
        Chart {
            ForEach(data) { shape in
                BarMark(
                    x: .value("모양", shape.type),
                    y: .value("합계", shape.count)
                )
                .foregroundStyle(by: .value("색깔", shape.color))
            }
        }
        .chartForegroundStyleScale([
            "초록색": .green, "보라색": .purple, "분홍색": .pink, "노랑색": .yellow
        ])
    }
}
