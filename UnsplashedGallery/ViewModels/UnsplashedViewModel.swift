//
//  UnsplashedViewModel.swift
//  UnsplashedGallery
//
//  Created by Jasjeev on 8/10/21.
//

import Foundation
import SwiftyJSON

final class UnsplashedViewModel: ObservableObject {
    @Published public var images = [UnsplashedImage]()
    
    private var searchText: String
    private var prevTypeTime: Double
    private var ignoreType: Bool
    
    private var baseURL = "https://api.unsplash.com/search/photos?page=1&per_page=50&client_id=" + accessKey + "&query="
    
    init() {
        self.searchText = "Coffee"
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
        if ((time - prevTypeTime)>0.9) {
            executeSearch()
        }
        else {
            if(!ignoreType) {
                ignoreType = true
                let after = (0.9 - (time - prevTypeTime)) + 0.2
                DispatchQueue.main.asyncAfter(deadline: .now() + after) {
                    self.checkSearchInterval(Date().timeIntervalSince1970)
                    self.ignoreType = false
                }
            }
        }
    }
    
    func executeSearch() {
        print(searchText)
        
        let url = baseURL + searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        makeRequest(url)
        // fetch 20 images from unspalshed
    }
    
    func makeRequest(_ stringurl: String) {
        guard let url = URL(string: stringurl) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if(error != nil){
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }
            else
            {
                if let data = data {
                    let json = JSON(data)
                    debugPrint(json)
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async { [self] in
                        processData(json)
                    }
                    // everything is good, so we can exit
                    return
                }
            }
        }.resume()
    }
    
    func processData(_ json: JSON) {
        // ensure images is empty
        self.images.removeAll()
        
        let result = json["results"]
        
        
        for (_, imageData):(String, JSON) in result {
            // create a new UnsplashedImage object

            // fix description
            let longDescription = imageData["description"].stringValue
            var shortDescription = String(longDescription.prefix(17))
            shortDescription = longDescription.count>17 ? shortDescription+"..." : shortDescription
            shortDescription = longDescription == "" ? "Unspecifed": shortDescription
            
            // set display name
            let first_name = imageData["user"]["first_name"].stringValue
            let last_name = imageData["user"]["last_name"].stringValue
            let displayName = first_name + " " + String(last_name.prefix(1)) + "."
            
            // add '@' to username
            let atUsername = "@" + imageData["user"]["username"].stringValue
            
            let currentImage = UnsplashedImage(
                id: UUID(),
                imageURL: imageData["urls"]["regular"].stringValue,
                description: shortDescription,
                profileImgURL: imageData["user"]["profile_image"]["large"].stringValue,
                displayName: displayName,
                username: atUsername,
                likes: imageData["likes"].intValue
            )
            
            self.images.append(currentImage)
        }
        
        print("done")
    }
    
    
    func cardTapped(_ id: UUID) {
        for image in images {
            if(image.id == id) {
                print("Tapped: " + image.description)
                return
            }
        }
    }
}
