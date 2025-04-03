//
//  ARViewContainer.swift
//  ARFace
//
//  Created by Justin Jiang on 3/30/25.
//

import SwiftUI
import ARKit
import SceneKit

struct ARViewContainer: UIViewRepresentable {
    @Binding var selectedFilter: FilterType
    @ObservedObject var sessionManager: ARSessionManager
    
    func makeUIView(context: Context) -> ARSCNView {
        let sceneView = ARSCNView(frame: .zero)
        sceneView.delegate = context.coordinator
        
        // Use front-facing camera for face tracking
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        sceneView.session.run(configuration)
        
        // Delay setting the sceneView on sessionManager to avoid modifying published properties during view updates.
        DispatchQueue.main.async {
            self.sessionManager.sceneView = sceneView
        }
        
        return sceneView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {
        // No dynamic updates needed.
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, ARSCNViewDelegate {
        var parent: ARViewContainer
        // Store the currently applied filter to avoid repeated re-application.
        var currentFilter: FilterType = .none
        
        init(_ parent: ARViewContainer) {
            self.parent = parent
            super.init()
        }
        
        // Called when ARKit detects a new face anchor
        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
            guard anchor is ARFaceAnchor else { return }
            print("✅ Face detected")
            currentFilter = parent.selectedFilter
            if currentFilter != .none {
                applyFilter(to: node)
            }
        }
        
        // Called when the face anchor is updated
        func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
            guard anchor is ARFaceAnchor else { return }
            // Only update the filter if the selected filter has changed.
            if parent.selectedFilter != currentFilter {
                // Remove any previously added filter nodes.
                node.childNodes.filter { $0.name == "filterNode" }.forEach { $0.removeFromParentNode() }
                currentFilter = parent.selectedFilter
                if currentFilter != .none {
                    applyFilter(to: node)
                }
            }
        }
        
        func applyFilter(to node: SCNNode) {
            let filter = parent.selectedFilter
            guard filter != .none else { return }
            
            var modelName: String?
            var fileExtension: String = "usdz"
            var position = SCNVector3Zero
            var scale = SCNVector3(1, 1, 1)
            var eulerAngles = SCNVector3Zero
            
            switch filter {
            case .blackPinkCatEars:
                modelName = "black-pink-cat-ears"
                fileExtension = "usdz"
                position = SCNVector3(0.035, -0.4, 0)
                scale = SCNVector3(0.0045, 0.004, 0.004)
            case .whiteAnimeCatEars:
                modelName = "white-anime-cat-ears"
                fileExtension = "usdz"
                position = SCNVector3(0, 0.07, -0.01)
                scale = SCNVector3(0.0015, 0.0015, 0.0015)
            case .japaneseMask:
                modelName = "japanese-mask"
                fileExtension = "usdz"
                position = SCNVector3(0, 0.031, 0)
                scale = SCNVector3(0.0015, 0.0015, 0.0015)
                eulerAngles = SCNVector3(0, 3.15, 0)
            case .dragonHead:
                modelName = "dragon-head"
                fileExtension = "usdz"
                position = SCNVector3(0, 0.006, 0.02)
                scale = SCNVector3(0.0045, 0.0045, 0.0045)
                eulerAngles = SCNVector3(0, -1.6, 0)
            case .ironmanhelmet:
                modelName = "ironman"
                fileExtension = "usdz"
                position = SCNVector3(0, -0.14, -0.04)
                scale = SCNVector3(0.001, 0.001, 0.001)
            case .batmanmask:
                modelName = "batman-mask"
                fileExtension = "usdz"
                position = SCNVector3(0, -0.043, -0.04)
                scale = SCNVector3(0.012, 0.012, 0.012)
            case .orangebird:
                modelName = "orange-bird"
                fileExtension = "usdz"
                position = SCNVector3(-0.12, -0.13, 0)
                scale = SCNVector3(0.0007, 0.0007, 0.0007)
                eulerAngles = SCNVector3(0, 0.8, 0)
            default:
                break
            }
            
            guard let name = modelName,
                  let modelURL = Bundle.main.url(forResource: name, withExtension: fileExtension) else {
                print("❌ ERROR: Model for \(filter.rawValue) not found in bundle.")
                return
            }
            
            guard let modelScene = try? SCNScene(url: modelURL, options: nil) else {
                print("❌ ERROR: Failed to load model scene for \(filter.rawValue).")
                return
            }
            
            print("✅ \(filter.rawValue) model loaded successfully.")
            
            let filterNode = SCNNode()
            filterNode.name = "filterNode"
            for child in modelScene.rootNode.childNodes {
                filterNode.addChildNode(child)
            }
            
            // For Position, x=0 and y=0 makes it so that the filter is around eye-level. So don't change x value. You can change y value to make it higher up.
            // For Scale, all values should be the same.
            // For EulerAngles, change only when necessary.
            //
            // Position: x: left/right, y: down/up, z: forward/back
            // Scale: x: width, y: height, z: depth
            // EulerAngles: x: rotate back/rotate forward, y: rotate to face left/rotate to face right, z: turn right/turn left
            //
            // Apply the filter's transformation settings
            filterNode.position = position
            filterNode.scale = scale
            filterNode.eulerAngles = eulerAngles
            
            print("🟢 \(filter.rawValue) Position: \(filterNode.position)")
            print("🟢 \(filter.rawValue) Scale: \(filterNode.scale)")
            
            node.addChildNode(filterNode)
            print("✅ \(filter.rawValue) successfully attached to face.")
        }
    }
}

