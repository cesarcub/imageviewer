//
//  ImageViewerApp.swift
//  ImageViewer
//
//  Created by César Cubillos on 12/10/23.
//

import SwiftUI

@main
struct ImageViewerApp: App {
    @State private var isActive = false
    var body: some Scene {
        WindowGroup {
            if isActive {
                ImageSelectorView()
            } else {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.isActive = true
                        }
                    }
            }
        }
    }
}
