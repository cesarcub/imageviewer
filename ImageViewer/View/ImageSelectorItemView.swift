//
//  ImageSelectorItemView.swift
//  ImageViewer
//
//  Created by César Cubillos on 15/10/23.
//

import SwiftUI

struct ImageSelectorItemView: View {
    @StateObject var imageItem: ImageSelectorItemViewModel
    var body: some View {
        HStack {
            if imageItem.isLoading {
                ProgressView()
                    .tint(kMainColor)
                    .padding(.trailing, 2)
            } else {
                imageItem.thumbnail
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            Text(imageItem.imageModel.title.capitalized)
                .padding(.leading, 5)
        }.onAppear {
            Task {
                try await imageItem.loadThumbnail()
            }
        }
    }
}

#Preview {
    ImageSelectorItemView(
        imageItem: ImageSelectorItemViewModel(ImageModel(albumId: 1, id: 1, title: "Data", url: "", thumbnailUrl: ""))
    )
}
