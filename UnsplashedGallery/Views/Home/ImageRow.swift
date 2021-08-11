//
//  ImageRow.swift
//  UnsplashedGallery
//
//  Created by Jasjeev on 8/10/21.
//

import SwiftUI
import URLImage

// A view that shows the data for one Image.
struct ImageRow: View {
    var unsplashedImage: UnsplashedImage
    @EnvironmentObject  var viewModel: UnsplashedViewModel

    var body: some View {
       GeometryReader { geo in
           HStack {
                URLImage(URL(string: unsplashedImage.imageURL)!) {
                    // This view is displayed before download starts
                    Rectangle()
                        .fill(Color.yellow)
                } inProgress: { progress in
                    // Display progress
                    Rectangle()
                        .fill(Color.yellow)
                } failure: { error, retry in
                    // Display error and retry button
                    Rectangle()
                        .fill(Color.red)
                } content: { image in
                    // Downloaded image
                    ZStack {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    }
                    .cornerRadius(0)
                    .frame(width: CGFloat(geo.size.width), height: CGFloat(216.0))
                }
           }
       }
    }
}

