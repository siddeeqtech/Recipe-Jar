//
//  LoadingView.swift
//  SwiftUI with Share extension 2
//
//  Created by othman shahrouri on 2/2/23.
//

import SwiftUI

struct LoadingView: View {
    let text: String
    var body: some View {
        VStack(spacing: 8) {
            ProgressView()
            Text (text) }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(text: "Fetching Data")
    }
}

