//
//  CapturedPhotoPreview.swift
//  ARFace
//
//  Created by Justin Jiang on 3/30/25.
//

import SwiftUI

struct CapturedPhotoPreview: View {
    let image: UIImage
    let onDiscard: () -> Void
    let onSave: () -> Void

    var body: some View {
        ZStack(alignment: .top) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            // Buttons are now pinned at the top and rendered in white.
            HStack {
                Button(action: onDiscard) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
                }
                Spacer()
                Button(action: onSave) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
                }
            }
            .padding(.top, 75)
            .padding(.horizontal, 20)
            .foregroundColor(.blue)
        }
    }
}
