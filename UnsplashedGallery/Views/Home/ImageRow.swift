//
//  ImageRow.swift
//  UnsplashedGallery
//
//  Created by Jasjeev on 8/10/21.
//

import SwiftUI

// A view that shows the data for one Image.
struct ImageRow: View {
    var unsplashedImage: UnsplashedImage

    var body: some View {
        HStack {
            ImageView(withURL: unsplashedImage.imageURL)
        }
    }
}
