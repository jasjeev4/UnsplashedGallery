//
//  HomeView.swift
//  UnsplashedGallery
//
//  Created by Jasjeev on 8/11/21.
//

import SwiftUI
import URLImage

struct HomeView: View {
    @State private var showingSheet = false
    @EnvironmentObject  var viewModel: UnsplashedViewModel
    
    var lightGrayOpaque = Color(red: 118 / 255, green: 118 / 255, blue: 128 / 255, opacity: 0.12)
    var imageGray = Color(red: 142 / 255, green: 142 / 255, blue: 147 / 255, opacity: 1)
    var searchGray = Color(red: 60 / 255, green: 60 / 255, blue: 67 / 255, opacity: 0.6)

    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Group {
                    Text("ACV Photo Challenge")
                        .font(.system(size: 17))
                        .fontWeight(.medium)
                        .padding(.top, 40)
                        .padding(.bottom, 10)
                    
                    HStack{
                        Group{
                            Image(systemName: "magnifyingglass")
                                .padding([.leading, .trailing], 8)
                                .foregroundColor(imageGray)
                            
                            TextField("Seach", text: $viewModel.searchText, onEditingChanged: { (changed) in
                                print("onEditingChanged - \(changed)")
                                viewModel.executeSearch()
                            }) {
                                print("onCommit")
                                viewModel.executeSearch()
                            }
                            .foregroundColor(searchGray)
                            
                            Image(systemName: "mic.fill")
                                .padding([.leading, .trailing], 8)
                                .foregroundColor(imageGray)
                        }.padding([.top, .bottom], 10)
                    }.background(lightGrayOpaque)
                     .cornerRadius(10)
                    
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(viewModel.images) { cardImage in
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
                                .frame(width: CGFloat(geo.size.width), height: CGFloat(216.0), alignment: .leading)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    viewModel.cardTapped(cardImage.id)
                                }
                            }
                        }
                    }.padding(.top, 10)
                }
            }
        }
        .padding([.leading, .trailing], 15)
        .sheet(isPresented: $viewModel.showingSheet) {
            SheetView().environmentObject(viewModel)
        }
        .onAppear{
            self.viewModel.executeSearch()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
