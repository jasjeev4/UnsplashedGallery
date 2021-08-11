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
    @EnvironmentObject  var viewModel: UnsplashedViewModel

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 5){
                Text(viewModel.sheetImage?.description ?? "Undefined")
                    .font(.system(size: 17))
                    .fontWeight(.medium)
                    .padding(.top, 15)
                
                Text(viewModel.sheetImage?.displayName ?? "Undefined")
                    .font(.system(size: 34))
                    .fontWeight(.semibold)
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                SheetImage(unsplashedImage: viewModel.sheetImage ?? UnsplashedImage(id: UUID(), imageURL: "", description: "", profileImgURL: "", displayName: "", username: "", likes: 0))
                    .frame(width: CGFloat(geo.size.width), height: CGFloat(498.0))
                    .environmentObject(viewModel)
            }
        }
            
//
//        Button("Press to dismiss") {
//            presentationMode.wrappedValue.dismiss()
//        }
//        .font(.title)
//        .padding()
//        .background(Color.black)
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
                        LazyVStack(spacing: 20) {
                            ForEach(viewModel.images) { cardImage in
                                ZStack {
        //                            Rectangle()
        //                                .fill(Color.yellow)
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
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .clipped()
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
        .sheet(isPresented: $viewModel.showingSheet) {
            SheetView().environmentObject(viewModel)
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
