//
//  HomeView.swift
//  UnsplashedGallery
//
//  Created by Jasjeev on 8/11/21.
//

import SwiftUI
import URLImage
import PopupView

struct HomeView: View {
    @EnvironmentObject  var viewModel: UnsplashedViewModel
    @State private var showingSheet = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    Group {
                        Text("ACV Photo Challenge")
                            .font(.system(size: 17))
                            .fontWeight(.medium)
                            .padding([.top, .bottom], 10)
                        
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
                                .font(.system(size: 17))
                                .foregroundColor(searchGray)
                                
                                Image(systemName: "mic.fill")
                                    .padding([.leading, .trailing], 8)
                                    .foregroundColor(imageGray)
                                    .onTapGesture {
                                        viewModel.speechRecognizer.record(to: $viewModel.transcript)
                                        viewModel.beginVoice()
                                    }
                            }.padding([.top, .bottom], 10)
                             .frame(minHeight: 36, maxHeight: 36)
                        }.background(lightGrayOpaque)
                         .cornerRadius(10)
                        
                        // show no result icon
                        if(viewModel.images.count < 1) {
                            HStack(alignment: .center) {
                                Spacer()
                                
                                VStack(alignment: .center) {
                                    Spacer()
                                    
                                    Image(systemName: "magnifyingglass.circle.fill")
                                        .resizable()
                                        .clipped()
                                        .frame(width: CGFloat(200.0), height: CGFloat(200.0))
                                        .foregroundColor(imageGray)
                                        .padding(10)
                                    
                                    Text("No Images found for this search.")
                                    Text("Try a different search.")
                                    
                                    Spacer()
                                }
                                
                                Spacer()
                            }
                        }
                        else {
                            ScrollView {
                                LazyVStack(spacing: 20) {
                                    ForEach(viewModel.images) { cardImage in
                                        CardView(cardImage: cardImage, width: geo.size.width)
                                    }
                                }
                            }.padding(.top, 10)
                        }
                    }
                }
            }.popup(isPresented: $viewModel.speechPopup) {
                VStack() {
                    if(viewModel.transcript.count < 1) {
                        Text("Say something...")
                            .frame(width: geo.size.width - CGFloat(100.0), height: 60)
                            .foregroundColor(Color.yellow)
                    }
                    else {
                        Text(viewModel.transcript)
                            .frame(width: geo.size.width - CGFloat(100.0), height: 60)
                            .foregroundColor(Color.white)
                    }
                    
                    Button("Done", action: viewModel.voiceComplete)
                        .padding([.bottom], 20)
                }
                .background(Color.black)
                .cornerRadius(30.0)
            }
        }
        .padding([.leading, .trailing], 15)
        .sheet(isPresented: $viewModel.showingSheet) {
            SheetView().environmentObject(viewModel)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
