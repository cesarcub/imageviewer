//
//  ImageDetailViewModel.swift
//  ImageViewer
//
//  Created by César Cubillos on 13/10/23.
//

import SwiftUI

class ImageDetailViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var imageModel: ImageModel
    @Published var photo: Image = Image(systemName: "photo.artframe")
    private let imagesClient = ImagesClient()
    private let localStorage = LocalStorage.shared
    
    init(_ imageModel: ImageModel) {
        self.imageModel = imageModel
    }
    
    
    /// Loads the photo images from local or fetching from API
    @MainActor func loadPhoto() async throws {
        if let photoStored = localStorage.load(from: .photoDetail, with: "\(imageModel.id)"),
           let dataImage = UIImage(data: photoStored){
            photo = Image(uiImage: dataImage)
        } else {
            try await fetchPhoto()
        }
        isLoading = false
    }
    
    /// Fecthes the photo from API
    @MainActor private func fetchPhoto() async throws {
        let photoFetched = try await APIManager.shared.downLoadData(from: imageModel.url)
        guard let image = UIImage(data: photoFetched),
              localStorage.save(in: .photoDetail, with: "\(imageModel.id)", object: photoFetched) else {
            return
        }
        photo = Image(uiImage: image)
    }
    
    /// Deletes photo API and local
    @MainActor func deletePhotoAPI() async throws -> Bool {
        if try await imagesClient.deleteImage(id: imageModel.id) {
            return deleteImageStored()
        }
        return false
    }
    
    /// Deletes photo in local
    private func deleteImageStored() -> Bool {
        guard var imagesStored = localStorage.load([ImageModel].self, from: .imageList) else {
            return true
        }
        imagesStored.removeAll(where: {$0.id == imageModel.id})
        localStorage.delete(from: .photoDetail)
        localStorage.delete(from: .thumbnail)
        return localStorage.save(in: .imageList, object: imagesStored)
    }
    
}
