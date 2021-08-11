//
//  ContentView.swift
//  UnsplashedGallery
//
//  Created by Jasjeev on 8/9/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UnsplashedViewModel()
    
    var body: some View {
        HomeView()
            .environmentObject(viewModel)
    }   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
