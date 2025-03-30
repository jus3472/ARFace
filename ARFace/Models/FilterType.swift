//
//  FilterType.swift
//  ARFace
//
//  Created by Justin Jiang on 3/30/25.
//

import Foundation

enum FilterType: String, CaseIterable, Identifiable {
    case none = "No Filter"
    case whiteAnimeCatEars = "White Anime Cat Ears"
    case whiteCatEarsHeadband = "White Cat Ears Headband"

    var id: String { self.rawValue }
}
