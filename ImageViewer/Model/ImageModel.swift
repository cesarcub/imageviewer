//
//  ImageModel.swift
//  ImageViewer
//
//  Created by César Cubillos on 12/10/23.
//

import SwiftUI

/// API Response photos model
struct ImageModel: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

struct ImageDataModel: Codable {
    let image: ImageModel
    let thumbnail: Data
    let fullImage: Data
}
