//
//  ChartExample.swift
//  SwiftUIForBlog
//
//  Created by 김민택 on 2023/03/22.
//

import Charts
import SwiftUI

struct Sales: Identifiable {
    var office: String
    var type: String
    var count: Double
    var id = UUID()
}

struct ChartExample: View {
    var data: [Sales] = [
        .init(office: "서울", type: "소보로", count: 40),
        .init(office: "서울", type: "도넛", count: 20),
        .init(office: "서울", type: "고로케", count: 90),
        .init(office: "대전", type: "소보로", count: 25),
        .init(office: "대전", type: "도넛", count: 15),
        .init(office: "대전", type: "고로케", count: 60),
        .init(office: "포항", type: "소보로", count: 15),
        .init(office: "포항", type: "도넛", count: 5),
        .init(office: "포항", type: "고로케", count: 30)
    ]

    var body: some View {
        // MARK: - .init(content: () -> Content)
//        Chart {
//            ForEach(data) { sales in
//                BarMark(
//                    x: .value("지점", sales.office),
//                    y: .value("합계", sales.count)
//                )
////                .foregroundStyle(by: .value("종류", sales.type))
//            }
//        }
////        .chartForegroundStyleScale([
////            "소보로": .purple, "도넛": .green, "고로케": .yellow
////        ])

        // MARK: - .init<Data, C>(Data, content: (Data.Element) -> C)
//        Chart(data) { sales in
//            BarMark(x: .value("지점", sales.office), y: .value("합계", sales.count))
////                .foregroundStyle(by: .value("종류", sales.type))
//        }
        Chart(data) {
            BarMark(
                y: .value("판매량", $0.count)
            )
            .foregroundStyle(by: .value("지점", $0.office))
        }
//        .chartForegroundStyleScale([
//            "소보로": .purple, "도넛": .green, "고로케": .yellow
//        ])
//
//        // MARK: - .init<Data, ID, C>(Data, id: KeyPath<Data.Element, ID>, content: (Data.Element) -> C)
//        Chart(data, id: \.id) { sales in
//            BarMark(x: .value("지점", sales.office), y: .value("합계", sales.count))
//                .foregroundStyle(by: .value("종류", sales.type))
//        }
//        .chartForegroundStyleScale([
//            "소보로": .purple, "도넛": .green, "고로케": .yellow
//        ])
    }
}

struct ChartExample_Previews: PreviewProvider {
    static var previews: some View {
        ChartExample()
    }
}
