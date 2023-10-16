//
//  SplashView.swift
//  ImageViewer
//
//  Created by César Cubillos on 13/10/23.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    var body: some View {
        if isActive {
            ImageSelectorView()
        } else {
            VStack {
                Image("SplashImage")
                Text("ImageViewer")
                    .font(.custom("Savoye LET", size: 40))
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .background(kMainColor)
            .ignoresSafeArea()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.isActive = true
                }
            }
        }
        
    }
}

#Preview {
    SplashView()
}
