//
//  ContentView.swift
//  ARFace
//
//  Created by Justin Jiang on 3/16/25.
//

import SwiftUI

struct ContentView: View {
    // Start on middle tab (Camera) by default
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PhotosView()
                .tabItem {
                    Label("Photos", systemImage: "photo")
                }
                .tag(0)
            
            CameraView()
                .tabItem {
                    Label("Camera", systemImage: "camera")
                }
                .tag(1)
            
            GamesView()
                .tabItem {
                    Label("Games", systemImage: "gamecontroller")
                }
                .tag(2)
        }
        .onAppear {
            // Ensure we start with the camera tab
            selectedTab = 1
        }
        .ignoresSafeArea(.keyboard) // This helps with any keyboard issues
    }
}

#Preview {
    ContentView()
}
