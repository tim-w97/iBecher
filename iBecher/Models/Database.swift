//
//  Database.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation
import RealityKit

final class Database {
    static let sharedInstance = Database()
    
    var allCoffeePurchases: [CoffeePurchase]
    
    let arView: ARView
    let topLidScene: TopLid.Scene?
    
    init() {
        allCoffeePurchases = []
        
        arView = ARView()
        
        // Load the Top Lid from the file
        do {
            let scene = try TopLid.loadScene()
            topLidScene = scene
        } catch {
            print("Something went wrong while loading the Top Lid Scene:")
            print(error)
            
            topLidScene = nil
        }
        
        // Place the Top Lid on the ground
        addTopLidToScene()
    }
    
    private func addTopLidToScene() {
        guard let topLidAnchor = topLidScene else {
            return
        }
        
        arView.scene.addAnchor(topLidAnchor)
    }
}
