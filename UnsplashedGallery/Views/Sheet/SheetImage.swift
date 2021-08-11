//
//  SheetImage.swift
//  UnsplashedGallery
//
//  Created by Jasjeev on 8/10/21.
//

import SwiftUI
import URLImage

// A view that shows the data for one Image.
struct SheetImage: View {
    var unsplashedImage: UnsplashedImage
    @EnvironmentObject  var viewModel: UnsplashedViewModel

    var body: some View {
       GeometryReader { geo in
           HStack {
                URLImage(URL(string: unsplashedImage.imageURL)!) {
                    // This view is displayed before download starts
                    Rectangle()
                        .fill(Color.yellow)
                        .cornerRadius(20)
                } inProgress: { progress in
                    // Display progress
                    Rectangle()
                        .fill(Color.yellow)
                        .cornerRadius(20)
                } failure: { error, retry in
                    // Display error and retry button
                    Rectangle()
                        .fill(Color.red)
                        .cornerRadius(20)
                } content: { image in
                    // Downloaded image
                    VStack {
                        Spacer()
                        
                        HStack {
                            ZStack {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geo.size.width - CGFloat(32), height: (498.0/343) * (geo.size.width - CGFloat(32)), alignment: .center)
                                    .clipped()
                                    .cornerRadius(20)
                            }
                        }
                        Spacer()
                    }
                }
           }.frame(width: geo.size.width - CGFloat(32), height: (498.0/343) * (geo.size.width - CGFloat(32)), alignment: .center)
            .padding([.leading, .trailing], 16)
       }
    }
}

