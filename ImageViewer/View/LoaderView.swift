//
//  LoaderView.swift
//  ImageViewer
//
//  Created by César Cubillos on 14/10/23.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        VStack(spacing: 20) {
            ProgressView()
                .progressViewStyle(.circular)
                .tint(.white)
                .scaleEffect(2)
            Text("Loading")
                .font(.custom(kMainFont, size: 50))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(kMainColor)
        .opacity(0.8)
    }
}

#Preview {
    LoaderView()
}
