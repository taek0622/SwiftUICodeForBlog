//
//  ContentView.swift
//  SwiftUIForBlog
//
//  Created by 김민택 on 2023/02/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            BarChart()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
