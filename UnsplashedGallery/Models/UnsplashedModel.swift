//
//  UnsplashedModel.swift
//  UnsplashedGallery
//
//  Created by Jasjeev on 8/10/21.
//

import Foundation

struct UnsplashedImage: Identifiable, Hashable {
    let id = UUID()
    var imageURL: String
    var description: String
    var profileImgURL: String
    var first_name: String
    var last_name: String
    var username: String
    var likes: Int
}
