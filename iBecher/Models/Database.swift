//
//  Database.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation
import RealityKit

// we want to make sure that no one creates an object of this class, so we make it final
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
        
        addDummyData()
    }
    
    private func addDummyData() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        
        allCoffeePurchases.append(
            CoffeePurchase(date: formatter.date(from: "01.01.2022 12:34")!, size: .small, mugType: .paperMug, cost: 12)
        )
        
        allCoffeePurchases.append(
            CoffeePurchase(date: formatter.date(from: "05.02.2022 13:34")!, size: .small, mugType: .reusableMug, cost: 23)
        )
        
        allCoffeePurchases.append(
            CoffeePurchase(date: formatter.date(from: "05.03.2022 13:34")!, size: .small, mugType: .reusableMug, cost: 34)
        )
        
        allCoffeePurchases.append(
            CoffeePurchase(date: formatter.date(from: "05.04.2022 13:34")!, size: .small, mugType: .reusableMug, cost: 45)
        )
    }
    
    private func addTopLidToScene() {
        guard let topLidAnchor = topLidScene else {
            return
        }
        
        arView.scene.addAnchor(topLidAnchor)
    }
}
