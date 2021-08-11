//
//  SheetView.swift
//  UnsplashedGallery
//
//  Created by Jasjeev on 8/11/21.
//

import SwiftUI
import URLImage

struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject  var viewModel: UnsplashedViewModel

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(alignment: .leading, spacing: 15){
                    Text(viewModel.sheetImage?.description ?? "Undefined")
                        .font(.system(size: 17))
                        .fontWeight(.medium)
                        .padding(.top, 15)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text(viewModel.sheetImage?.displayName ?? "Undefined")
                        .font(.system(size: 34))
                        .fontWeight(.semibold)
                        .padding(.leading, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ZStack{
                        SheetImage(unsplashedImage: viewModel.sheetImage ?? UnsplashedImage(id: UUID(), imageURL: "", largeURL: "", description: "", profileImgURL: "", displayName: "", username: "", likes: 0))
                            .frame(width: CGFloat(geo.size.width), height: (498.0/343) * (geo.size.width - CGFloat(32)))
                            .environmentObject(viewModel)
                    }.cornerRadius(20)
                    
                    
                    VStack(spacing: 12) {
                        HStack(spacing: 6) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        
                            Text(String(viewModel.sheetImage?.likes ?? 0))
                                .font(.system(size: 14))
                                .fontWeight(.light)
                            
                            Spacer()
                        }
                        
                        HStack {
                            URLImage(URL(string: viewModel.sheetImage?.profileImgURL ?? "")!) {
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
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                        .frame(width: CGFloat(50.0), height: CGFloat(50.0))
                                        .cornerRadius(100)
                                        //.offset(x: 2, y: 2)
                                        .zIndex(1)
                                }
                                .cornerRadius(100)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(viewModel.sheetImage?.displayName ?? "Undefined")
                                    .font(.system(size: 18))
                                    .fontWeight(.medium)
                                
                                Text(viewModel.sheetImage?.username ?? "Undefined")
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                            }
                            
                            Spacer()
                        }
                    }.padding([.leading], 26)
                    .padding([.bottom], 20)
                }
            }
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}
