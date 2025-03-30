//
//  FilterCircleView.swift
//  ARFace
//
//  Created by Justin Jiang on 3/30/25.
//

// FilterCircleView.swift
import SwiftUI

struct FilterCircleView: View {
    let filter: FilterType
    let isSelected: Bool
    
    // For the "no filter" option use grey; for others, a placeholder color (blue) is used.
    var fillColor: Color {
        switch filter {
        case .none:
            return Color.gray
        default:
            return Color.blue
        }
    }
    
    // Display text for each filter (shortened for the circle)
    var displayText: String {
        switch filter {
        case .none:
            return "No"
        case .whiteAnimeCatEars:
            return "Anime"
        case .whiteCatEarsHeadband:
            return "Headband"
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(fillColor)
                .frame(width: 60, height: 60)
            Text(displayText)
                .font(.caption)
                .foregroundColor(.white)
        }
        .overlay(
            Circle().stroke(isSelected ? Color.white : Color.clear, lineWidth: 3)
        )
    }
}
