//
//  ContentView.swift
//  UnsplashedGallery
//
//  Created by Jasjeev on 8/9/21.
//

import SwiftUI
import URLImage

struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button("Press to dismiss") {
            presentationMode.wrappedValue.dismiss()
        }
        .font(.title)
        .padding()
        .background(Color.black)
    }
}

struct ContentView: View {
    @StateObject private var viewModel = UnsplashedViewModel()
    
    @State private var showingSheet = false
    @State var searchInput: String = ""
    
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
                            
                            TextField("Search", text: $searchInput)
                                .onChange(of: searchInput) {
                                    viewModel.onSearchChange($0)
                                }
                                .foregroundColor(searchGray)
                            
                            Image(systemName: "mic.fill")
                                .padding([.leading, .trailing], 8)
                                .foregroundColor(imageGray)
                        }.padding([.top, .bottom], 10)
                    }.background(lightGrayOpaque)
                     .cornerRadius(10)
                    
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.images) { image in
                                ZStack {
        //                            Rectangle()
        //                                .fill(Color.yellow)
                                    
                                    ImageRow(unsplashedImage: image)
                                        .onTapGesture {
                                            self.viewModel.cardTapped(image.id)
                                        }
                                }.cornerRadius(20)
                                .frame(width: CGFloat(geo.size.width), height: CGFloat(216.0), alignment: .leading)
                            }
                        }
                    }
                    
//                    List(self.viewModel.images) { image in
//                        ZStack {
//                            ImageRow(unsplashedImage: image)
//                                .onTapGesture {
//                                    self.viewModel.cardTapped(image.id)
//                                }
//                        }.cornerRadius(20)
//                        .frame(width: CGFloat(geo.size.width), height: CGFloat(216.0), alignment: .leading)
//                    }
//                     .listStyle(SidebarListStyle())
//                     .padding(.leading, -20)
                }
                
//                    ForEach(viewModel.images, id: \.self) { imageRow in
//                        ZStack {
//                            URLImage(URL(string: imageRow.imageURL)!) {
//                                // This view is displayed before download starts
//                                EmptyView()
//                            } inProgress: { progress in
//                                // Display progress
//                                EmptyView()
//                            } failure: { error, retry in
//                                // Display error and retry button
//                                Image("no-image")
//                            } content: { image in
//                                // Downloaded image
//                                ZStack {
//                                    image
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fill)
//                                        .clipped()
//                                }
//                                .cornerRadius(0)
//                                .frame(width: CGFloat(geo.size.width - 10.0), height: CGFloat(216.0))
//                            }
//                        }.frame(width: CGFloat(geo.size.width - 10.0), height: CGFloat(216.0))
//                        .padding(.bottom, 100)
            }
        
//            
//            Spacer()
//        
//            Button("Show Sheet") {
//                showingSheet.toggle()
//            }
//            
//            Spacer()
        }
        .padding([.leading, .trailing], 15)
        .sheet(isPresented: $showingSheet) {
            SheetView()
        }
        .onAppear{
            self.viewModel.executeSearch()  
        }
    }   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
