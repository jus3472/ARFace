// CameraView.swift
import SwiftUI

struct CameraView: View {
    @State private var selectedFilter: FilterType = .none
    @StateObject private var sessionManager = ARSessionManager()
    @State private var capturedImage: UIImage? = nil
    @EnvironmentObject var photoLibrary: PhotoLibrary
    
    var body: some View {
        ZStack {
            // AR view container
            ARViewContainer(selectedFilter: $selectedFilter, sessionManager: sessionManager)
                .edgesIgnoringSafeArea(.all)
            
            if capturedImage == nil {
                // Live camera overlay controls
                VStack {
                    Spacer()
                    
                    FilterSelectorView(selectedFilter: $selectedFilter)
                    
                    CaptureButton(action: capturePhoto)
                        .padding(.bottom, 20)
                }
            } else {
                // Snapshot preview overlay
                CapturedPhotoPreview(image: capturedImage!,
                                     onDiscard: { capturedImage = nil },
                                     onSave: {
                                         photoLibrary.addPhoto(capturedImage!)
                                         capturedImage = nil
                                     })
            }
        }
    }
    
    func capturePhoto() {
        if let snapshot = sessionManager.captureSnapshot() {
            capturedImage = snapshot
        }
    }
}
