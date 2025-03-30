//
//  PhotosView.swift
//  ARFace
//
//  Created by Justin Jiang on 3/16/25.
//

import SwiftUI

struct PhotosView: View {
    @EnvironmentObject var photoLibrary: PhotoLibrary
    @State private var selectedPhoto: Photo? = nil

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(photoLibrary.photos) { photo in
                        if let image = photo.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipped()
                                .onTapGesture {
                                    selectedPhoto = photo
                                }
                        } else {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 100, height: 100)
                                .onTapGesture {
                                    selectedPhoto = photo
                                }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Photos")
            .sheet(item: $selectedPhoto) { photo in
                FullScreenPhotoView(photo: photo,
                                    onDelete: {
                                        photoLibrary.deletePhoto(photo)
                                        selectedPhoto = nil
                                    },
                                    onDone: {
                                        selectedPhoto = nil
                                    })
            }
        }
    }
}
