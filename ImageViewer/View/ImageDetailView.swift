//
//  ImageDetailView.swift
//  ImageViewer
//
//  Created by César Cubillos on 13/10/23.
//

import SwiftUI

struct ImageDetailView: View {
    @StateObject var imageDetail: ImageDetailViewModel
    @State private var isConfirmShow = false
    @Environment(\.dismiss) var isShowingDetailView
    @EnvironmentObject var imageListViewModel: ImageSelectorViewModel
    
    var body: some View {
        ZStack {
            VStack {
                if imageDetail.isLoading {
                    ProgressView()
                        .tint(kMainColor)
                        .onAppear(){
                            Task {
                                try await imageDetail.loadPhoto()
                            }
                        }
                } else {
                    imageDetail.photo
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(20)
                }
                Divider()
                VStack {
                    Text(imageDetail.imageModel.title.capitalized)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Button(role: .destructive) {
                        isConfirmShow = true
                    } label: {
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .buttonBorderShape(.roundedRectangle(radius: 20))
                            .foregroundStyle(.red)
                    }
                    .confirmationDialog(
                        "¿Deseas eliminar la imagen?",
                        isPresented: $isConfirmShow,
                        titleVisibility: .visible
                    ) {
                        Button("Si", role: .destructive) {
                            Task {
                                guard let newList = try await imageDetail.deletePhotoAPI() else {
                                    return
                                }
                                imageListViewModel.imageList = newList
                                self.isShowingDetailView()
                            }
                        }
                        Button("No", role: .cancel ) {}
                    }
                }
                .padding(20)
            }
        }
    }
}

#Preview {
    ImageDetailView(imageDetail: ImageDetailViewModel(
        ImageModel(
            albumId: 1,
            id: 1,
            title: "ImageTest",
            url: "https://via.placeholder.com/600/92c952",
            thumbnailUrl: "https://via.placeholder.com/150/92c952"))
    )
}
