//
//  ARSessionManager.swift
//  ARFace
//
//  Created by Justin Jiang on 3/30/25.
//

import ARKit
import SwiftUI

class ARSessionManager: ObservableObject {
    @Published var sceneView: ARSCNView?
    
    func captureSnapshot() -> UIImage? {
        return sceneView?.snapshot()
    }
}
