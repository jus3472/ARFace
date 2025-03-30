//
//  CaptureButton.swift
//  ARFace
//
//  Created by Justin Jiang on 3/30/25.
//

import SwiftUI

struct CaptureButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Circle()
                .fill(Color.white)
                .frame(width: 70, height: 70)
                .overlay(Circle().stroke(Color.black, lineWidth: 2))
        }
    }
}
