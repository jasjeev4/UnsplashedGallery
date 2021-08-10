//
//  UnsplashedViewModel.swift
//  UnsplashedGallery
//
//  Created by Jasjeev on 8/10/21.
//

import Foundation

final class UnsplashedViewModel: ObservableObject {
    
    private var searchText: String
    private var prevTypeTime: Double
    private var ignoreType: Bool
    
    init() {
        self.searchText = ""
        self.prevTypeTime = 0
        self.ignoreType = false
    }
    
    func onSearchChange(_ text: String) {
        searchText = text
        prevTypeTime = Date().timeIntervalSince1970
        checkSearchInterval(prevTypeTime)
    }
    
    func checkSearchInterval(_ time: Double) {
        // check if 1 second has gone by since the user typed
        if ((time - prevTypeTime)>1) {
            executeSearch()
        }
        else {
            let after = 1.0 - (time - prevTypeTime)
            if(!ignoreType) {
                ignoreType = true
                DispatchQueue.main.asyncAfter(deadline: .now() + after) {
                    self.checkSearchInterval(Date().timeIntervalSince1970)
                    self.ignoreType = false
                }
            }
        }
    }
    
    func executeSearch() {
        print(searchText)
    }
}
