//
//  ContentView.swift
//  UnsplashedGallery
//
//  Created by Jasjeev on 8/9/21.
//

import SwiftUI

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
    @State private var showingSheet = false
    
    @State var searchInput: String = ""
    
    var lightGrayOpaque = Color(red: 118 / 255, green: 118 / 255, blue: 128 / 255, opacity: 0.12)
    var imageGray = Color(red: 142 / 255, green: 142 / 255, blue: 147 / 255, opacity: 1)
    var searchGray = Color(red: 60 / 255, green: 60 / 255, blue: 67 / 255, opacity: 0.6)

    var body: some View {
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
                            .foregroundColor(searchGray)
                        
                        Image(systemName: "mic.fill")
                            .padding([.leading, .trailing], 8)
                            .foregroundColor(imageGray)
                    }.padding([.top, .bottom], 10)
                }.background(lightGrayOpaque)
                 .cornerRadius(10)
            }
            
            Spacer()
        
            Button("Show Sheet") {
                showingSheet.toggle()
            }
            
            Spacer()
        }
        .padding([.leading, .trailing], 15)
        .sheet(isPresented: $showingSheet) {
            SheetView()
        }
    }   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
