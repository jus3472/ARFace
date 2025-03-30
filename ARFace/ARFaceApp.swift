//
//  ARFaceApp.swift
//  ARFace
//
//  Created by Justin Jiang on 3/16/25.
//

import SwiftUI

@main
struct ARFaceApp: App {
    @StateObject var photoLibrary = PhotoLibrary()
    
    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor.white
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        UITabBar.appearance().tintColor = .black // sets the icon color to black
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(photoLibrary)
        }
    }
}

