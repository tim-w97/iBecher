//
//  Database.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation
import RealityKit

// we want to make sure that no one creates an object of this class, so we make it final
struct Database {
    static var sharedInstance = Database()
    
    var coffeePurchases: [CoffeePurchase]
    let arView: ARView
    
    init() {
        coffeePurchases = []
        arView = ARView()
    }
}
