//
//  LocalizationView.swift
//  SwiftUIForBlog
//
//  Created by 김민택 on 3/30/24.
//

import SwiftUI

enum Language {
    static let language = "한국어"
    static let nationalNumber = 82
}

struct LocalizationView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack {
                Text("현재 언어")
                    .font(.title2)
                    .foregroundStyle(.white)

                Text(Language.language)
                    .font(.largeTitle)
                    .foregroundStyle(.white)

                Image("National Flag")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(40)

                Text("국가 번호: +\(Language.nationalNumber)")
                    .font(.title2)
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    LocalizationView()
}
