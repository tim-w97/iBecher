//
//  MugCheckerVM.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation
import RealityKit

class MugCheckerVM : ObservableObject {
    // height of the Top Lid in cm
    @Published var topLidHeight: Float {
        didSet {
            changeTopLidHeight()
        }
    }
    
    let arView: ARView
    
    init() {
        topLidHeight = 12
        arView = Database.sharedInstance.arView
    }
    
    func changeTopLidHeight() {
        if arView.scene.anchors.count == 0 {
            return
        }
        
        guard let topLidScene = arView.scene.anchors.first as? TopLid.Scene else {
            return
        }
        
        guard let topLid = topLidScene.topLid else {
            return
        }
        
        guard let topLidText = topLidScene.topLidText else {
            return
        }
        
        // we need to pass in the new position in meters, so we divide the values by 100
        topLid.position.y = topLidHeight / 100
        topLidText.position.y = (topLidHeight + 1) / 100
        
        var material = SimpleMaterial()
        
        if topLidHeight > 13 {
            material.color = .init(tint: .red)
        } else {
            material.color = .init(tint: .green)
        }
        
        guard let modelEntity = topLid.children.first as? ModelEntity else {
            return
        }
        
        modelEntity.model?.materials.removeAll()
        modelEntity.model?.materials.append(material)
    }
}
