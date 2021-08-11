//
//  UnsplashedModel.swift
//  UnsplashedGallery
//
//  Created by Jasjeev on 8/10/21.
//

import Foundation

struct UnsplashedImage: Identifiable {
    let id: UUID
    var imageURL: String
    var description: String
    var profileImgURL: String
    var displayName: String
    var username: String
    var likes: Int
}

