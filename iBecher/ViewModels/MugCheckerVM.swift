//
//  MugCheckerVM.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation
import RealityKit

class MugCheckerVM : ObservableObject {
    let arView: ARView
    
    init() {
        arView = ARView(
            frame: .zero,
            cameraMode: .ar,
            automaticallyConfigureSession: true
        )
        
        addTopLidToScene()
    }
    
    private func addTopLidToScene() {
        guard let topLidAnchor = loadTopLidScene() else {
            return
        }
        
        arView.scene.addAnchor(topLidAnchor)
    }
    
    private func loadTopLidScene() -> TopLid.Scene? {
        do {
            let scene = try TopLid.loadScene()
            return scene
        } catch {
            print("Something went wrong while loading the Top Lid Scene:")
            print(error)
        }
        
        return nil
    }
}
