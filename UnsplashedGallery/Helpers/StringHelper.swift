//
//  StringHelper.swift
//  UnsplashedGallery
//
//  Created by Jasjeev on 8/11/21.
//

import Foundation

extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}
