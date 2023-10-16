//
//  SplashView.swift
//  ImageViewer
//
//  Created by César Cubillos on 13/10/23.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack {
            Image("SplashImage")
            Text("ImageViewer")
                .font(.custom("Savoye LET", size: 40))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(kMainColor)
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
