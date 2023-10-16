//
//  ImageSelectorItemViewModel.swift
//  ImageViewer
//
//  Created by César Cubillos on 15/10/23.
//

import SwiftUI

class ImageSelectorItemViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var imageModel: ImageModel
    @Published var thumbnail: Image = Image(systemName: "photo.artframe")
    
    private let localStorage = LocalStorage.shared
    
    init(_ imageModel: ImageModel) {
        self.imageModel = imageModel
    }
    
    
    /// Loads the thumbnail images from local or fetching from API
    @MainActor func loadThumbnail() async throws {
        if let thumbnailStored = localStorage.load(from: .thumbnail, with: "\(imageModel.id)"),
           let dataImage = UIImage(data: thumbnailStored){
            thumbnail = Image(uiImage: dataImage)
        } else {
            try await fetchThumbnail()
        }
        isLoading = false
    }
    
    /// Fecthes the thumbnail from API
    @MainActor private func fetchThumbnail() async throws {
        let thumbnailFetched = try await APIManager.shared.downLoadData(from: imageModel.thumbnailUrl)
        guard let image = UIImage(data: thumbnailFetched),
            localStorage.save(in: .thumbnail, with: "\(imageModel.id)", object: thumbnailFetched) else {
            return
        }
        thumbnail = Image(uiImage: image)
    }
}
