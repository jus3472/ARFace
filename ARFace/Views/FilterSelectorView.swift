//
//  FilterSelectorView.swift
//  ARFace
//
//  Created by Justin Jiang on 3/30/25.
//

import SwiftUI

struct FilterSelectorView: View {
    @Binding var selectedFilter: FilterType

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(FilterType.allCases) { filter in
                    Button(action: {
                        selectedFilter = filter
                    }) {
                        VStack {
                            // Placeholder icons – you can replace these with your own thumbnails.
                            Image(systemName: filter == .none ? "camera" : "sparkles")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .padding()
                                .background(selectedFilter == filter ? Color.blue.opacity(0.5) : Color.gray.opacity(0.3))
                                .clipShape(Circle())
                            Text(filter.rawValue)
                                .font(.caption)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
        .background(Color.black.opacity(0.3))
    }
}
