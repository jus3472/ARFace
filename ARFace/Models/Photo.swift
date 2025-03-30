//
//  Photo.swift
//  ARFace
//
//  Created by Justin Jiang on 3/30/25.
//

import SwiftUI

struct Photo: Identifiable, Codable, Equatable {
    let id: String
    let fileName: String

    // Computed property to load image from disk
    var image: UIImage? {
        let url = PhotoLibrary.documentsDirectory.appendingPathComponent(fileName)
        return UIImage(contentsOfFile: url.path)
    }
}
