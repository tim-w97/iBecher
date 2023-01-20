//
//  Database.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation
import RealityKit

/// The database which provides the coffee purchases and the ar view from a shared instance / single source of truth
struct Database {
    /// The shared instance always points at one single source of truth
    static var sharedInstance = Database()
    
    var coffeePurchases: [CoffeePurchase]
    let arView: ARView
    
    /// initializes the coffee purchases with an empty list, because the coffee purchases from the disk are loaded asynchronously, and creates a new ar view
    init() {
        coffeePurchases = []
        arView = ARView()
    }
}
