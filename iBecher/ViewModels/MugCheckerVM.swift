//
//  MugCheckerVM.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation
import RealityKit
import UIKit
import ARKit

class MugCheckerVM : ObservableObject {
    let initialTopLidHeight : Float = 12
    let minTopLidHeight: Float = 4
    let maxTopLidHeight: Float = 20
    let topLidHeightSliderStep: Float = 1
    let maxCupHeight: Float = 12
    
    var topLidScene: TopLid.Scene!
    
    // height of the Top Lid in cm
    @Published var topLidHeight: Float {
        didSet {
            changeTopLidHeight()
        }
    }
    
    @Published var lidIsOverMaxCupHeight: Bool
    
    let modelInterface: ModelInterface
    let arView: ARView
    
    /// Initializes all attributes and the ar view
    init() {
        modelInterface = ModelInterface()
        
        topLidHeight = initialTopLidHeight
        arView = modelInterface.getARView()
        
        lidIsOverMaxCupHeight = false
        
        initARView()
    }
    
    /// Changes the top lid height relative to the sliders value and changes the color to green or red, depending on the max height
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
        topLidText.position.y = topLidHeight / 100
        
        lidIsOverMaxCupHeight = topLidHeight > maxCupHeight
        
        changeColorOf(entity: topLid, to: lidIsOverMaxCupHeight ? .red : .green)
    }
    
    /// Loads the Top Lid and adds it to the ar view scene
    private func initARView() {
        addCoachingOverlay()
        
        // Load the Top Lid from the file
        do {
            let scene = try TopLid.loadScene()
            topLidScene = scene
        } catch {
            fatalError(error.localizedDescription)
        }
        
        // Place the Top Lid on the ground
        arView.scene.addAnchor(topLidScene)
    }
    
    /// Creates a coaching overlay for a better user experience and adds it to the ar view
    private func addCoachingOverlay() {
        let session = arView.session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        session.run(config)
        
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = session
        coachingOverlay.goal = .horizontalPlane
        arView.addSubview(coachingOverlay)
    }
    
    /// Changes the color of an entity to a given color
    /// - Parameters:
    ///   - entity: The entity to add the color to
    ///   - to: The color to add
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
