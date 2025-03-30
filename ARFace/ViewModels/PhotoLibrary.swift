//
//  PhotoLibrary.swift
//  ARFace
//
//  Created by Justin Jiang on 3/30/25.
//

import SwiftUI

class PhotoLibrary: ObservableObject {
    @Published var photos: [Photo] = []
    private let photosKey = "SavedPhotos"

    static var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    init() {
        loadPhotos()
    }

    func addPhoto(_ image: UIImage) {
        // Generate a unique file name
        let id = UUID().uuidString
        let fileName = "\(id).jpg"
        let url = PhotoLibrary.documentsDirectory.appendingPathComponent(fileName)

        if let data = image.jpegData(compressionQuality: 0.8) {
            do {
                try data.write(to: url)
                let photo = Photo(id: id, fileName: fileName)
                photos.append(photo)
                savePhotoMetadata()
            } catch {
                print("❌ Error saving photo: \(error)")
            }
        }
    }

    func deletePhoto(_ photo: Photo) {
        // Remove file from disk
        let url = PhotoLibrary.documentsDirectory.appendingPathComponent(photo.fileName)
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("❌ Error deleting photo file: \(error)")
        }
        // Remove photo from array and update metadata
        photos.removeAll { $0.id == photo.id }
        savePhotoMetadata()
    }

    private func savePhotoMetadata() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(photos) {
            UserDefaults.standard.set(encoded, forKey: photosKey)
        }
    }

    private func loadPhotos() {
        if let data = UserDefaults.standard.data(forKey: photosKey) {
            let decoder = JSONDecoder()
            if let savedPhotos = try? decoder.decode([Photo].self, from: data) {
                photos = savedPhotos
            }
        }
    }
}
