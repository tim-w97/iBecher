//
//  MugCheckerARViewContainer.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation
import RealityKit
import SwiftUI

struct MugCheckerARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        // TODO: implement this.
        
        let arView = ARView(frame: .zero)
        
        let mugAnchor = try! PlasticMug.loadScene()
        
        arView.scene.addAnchor(mugAnchor)
        
        return arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // TODO: implement this.
    }
}
