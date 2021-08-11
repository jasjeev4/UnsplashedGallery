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
                                    VStack {
                                        HStack {
                                            Text(image.description)
                                                .font(.system(size: 24))
                                                .fontWeight(.medium)
                                                .foregroundColor(.white)
                                                .offset(x: 16, y: 29)
                                            
                                            Spacer()
                                        }
                                        Spacer ()
                                        
                                    }.zIndex(1)
                                    
                                    ImageRow(unsplashedImage: image)
                                        .zIndex(0)
                                }.cornerRadius(20)
                                .frame(width: CGFloat(geo.size.width), height: CGFloat(216.0), alignment: .leading)
                                .padding(.bottom, 15)
                                .onTapGesture {
                                    self.viewModel.cardTapped(image.id)
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
