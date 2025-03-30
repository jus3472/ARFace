//
//  FullScreenPhotoView.swift
//  ARFace
//
//  Created by Justin Jiang on 3/30/25.
//

import SwiftUI

struct FullScreenPhotoView: View {
    let photo: Photo
    let onDelete: () -> Void
    let onDone: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let image = photo.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .background(Color.black)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Color.black.edgesIgnoringSafeArea(.all)
            }
            HStack {
                Button(action: onDelete) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding()
                }
                Spacer()
                Button(action: onDone) {
                    Text("Done")
                        .font(.headline)
                        .padding(10)
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(8)
                        .padding()
                }
            }
        }
    }
}

