//
//  FilterType.swift
//  ARFace
//
//  Created by Justin Jiang on 3/30/25.
//

import Foundation

enum FilterType: String, CaseIterable, Identifiable {
    case none = "No Filter"
    case blackPinkCatEars = "Black Pink Cat Ears"
    case whiteAnimeCatEars = "White Anime Cat Ears"
    case japaneseMask = "Japanese Mask"
    case dragonHead = "Dragon Head"
    case ironmanhelmet = "Ironman Helmet"
    case batmanmask = "Batman Mask"
    case orangebird = "Orange Bird"
    var id: String { self.rawValue }
}
