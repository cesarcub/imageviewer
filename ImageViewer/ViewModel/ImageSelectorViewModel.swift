//
//  ImageSelectorViewModel.swift
//  ImageViewer
//
//  Created by César Cubillos on 13/10/23.
//

import Foundation

class ImageSelectorViewModel: ObservableObject {
    @Published var imageList: [ImageModel] = []
    @Published var isLoading = true
    private let imagesClient = ImagesClient()
    private let localStorage = LocalStorage.shared
    
    /// Get images from local storage or from API
    @MainActor func getImages() async throws {
        if let imagesStored = localStorage.load([ImageModel].self, from: .imageList) {
            imageList = imagesStored
            isLoading = false
        } else {
            try await fetchImages()
        }
    }
    
    /// Get images from API
    @MainActor func fetchImages() async throws {
        self.isLoading = true
        guard let images = try await imagesClient.getImages(),
              localStorage.save(in: .imageList, object: images) else {
            return
        }
        self.isLoading = false
        imageList = images
    }
    
}
