//
//  ContentView.swift
//  SwiftUIForBlog
//
//  Created by 김민택 on 2023/02/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("차트예제", destination: ChartExample())
                NavigationLink("바 차트", destination: BarChart())
                NavigationLink("바 마크", destination: BarMarkXYInterval())
                NavigationLink("코어 이미지 사진 필터", destination: CoreImagePhotoFilterView())
                NavigationLink("다국어 지원", destination: LocalizationView())
                NavigationLink("공유 시트", destination: ShareLinkView())
                NavigationLink("실시간 채팅 (웹 소켓)", destination: ChattingView())
                NavigationLink("커스텀 탭뷰", destination: CustomTabView())
                NavigationLink("이미지 확장자 변경", destination: ImageFormatCovertView())
                NavigationLink("컨텍스트 메뉴", destination: MessageAppGroupUIView())
                NavigationLink("네비게이션의 종류", destination: NavigationTypeView())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
