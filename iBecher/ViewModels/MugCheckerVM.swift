//
//  MugCheckerVM.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation
import RealityKit
import UIKit

class MugCheckerVM : ObservableObject {
    private let initialTopLidHeight : Float = 12
    let minTopLidHeight: Float = 4
    let maxTopLidHeight: Float = 20
    let topLidHeightSliderStep: Float = 1
    let maxCupHeight: Float = 14
    
    // height of the Top Lid in cm
    @Published var topLidHeight: Float {
        didSet {
            changeTopLidHeight()
        }
    }
    
    let modelInterface: ModelInterface
    let arView: ARView
    
    init() {
        modelInterface = ModelInterface()
        
        topLidHeight = initialTopLidHeight
        arView = modelInterface.getARView()
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
        
        if topLidHeight > maxCupHeight {
            changeColorOf(entity: topLid, to: .red)
        } else {
            changeColorOf(entity: topLid, to: .green)
        }
    }
    
    private func changeColorOf(entity: Entity, to: UIColor) {
        var material = SimpleMaterial()
        
        material.color = .init(tint: to)
        
        guard let modelEntity = entity.children.first as? ModelEntity else {
            return
        }
        
        modelEntity.model?.materials.removeAll()
        modelEntity.model?.materials.append(material)
    }
}
