//
//  ClientImages.swift
//  ImageViewer
//
//  Created by César Cubillos on 12/10/23.
//

import SwiftUI

/// Client to images API
class ImagesClient {
    
    /// Retrieve images from API
    /// - Returns: An optional image array
    func getImages() async throws -> [ImageModel]? {
        do {
            let (imagesList, _) = try await APIManager.shared
                .fetch(
                    [ImageModel].self,
                    with: .get,
                    from: "\(kUrlImages)/photos"
                )
            return imagesList
        } catch {
            return nil
        }
    }
    
    /// Delete images  with a given ID
    /// - Parameters:
    ///   - id: Image identifier
    /// - Returns: An optional image array
    func deleteImage(id: Int) async throws -> Bool {
        do {
            let (_, response) = try await APIManager.shared
                .fetch(
                    Data.self,
                    with: .delete,
                    from: "\(kUrlImages)/photos/\(id)"
                )
            return response == .success
        } catch {
            return false
        }
    }
}
