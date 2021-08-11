//
//  CardView.swift
//  UnsplashedGallery
//
//  Created by Jasjeev on 8/11/21.
//

import SwiftUI
import URLImage

struct CardView: View {
    var cardImage: UnsplashedImage
    var width: CGFloat
    @EnvironmentObject  var viewModel: UnsplashedViewModel
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text(cardImage.description)
                        .font(.system(size: 24))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .offset(x: 16, y: 29)
                    
                    Spacer()
                }
                Spacer ()
                
            }.zIndex(2)
            
            VStack {
                Spacer ()
                
                HStack {
                    URLImage(URL(string: cardImage.profileImgURL)!) {
                        // This view is displayed before download starts
                        EmptyView()
                    } inProgress: { progress in
                        // Display progress
                        EmptyView()
                    } failure: { error, retry in
                        // Display error and retry button
                        Image("no-image")
                    } content: { image in
                        // Downloaded image
                        ZStack {
                            Rectangle()
                                .fill(Color.white)
                                .zIndex(0)
                            
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                                .frame(width: CGFloat(45.0), height: CGFloat(45.0))
                                .cornerRadius(100)
                                //.offset(x: 2, y: 2)
                                .zIndex(1)
                        }
                        .cornerRadius(100)
                        .frame(width: CGFloat(50.0), height: CGFloat(50.0))
                    }
                    
                    VStack(alignment: .leading) {
                        Text(cardImage.displayName)
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        
                        Text(cardImage.username)
                            .font(.system(size: 14))
                            .fontWeight(.light)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                }.offset(x: 20, y: -20)
            }.zIndex(2)
            
            CardImage(unsplashedImage: cardImage)
                .environmentObject(viewModel)
                .zIndex(1)
        }
        .cornerRadius(20)
        .frame(width: CGFloat(width), height: CGFloat(216.0), alignment: .leading)
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.cardTapped(cardImage.id)
        }
    }
}
