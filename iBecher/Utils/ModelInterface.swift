//
//  ModelInterface.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation
import RealityKit

/// The Model Interface is responsible for getting and adding coffee purchases to the database and the users disk
class ModelInterface {
    var index: Int
    
    /// Sets the index to 0 to always load the first coffee purchase
    init() {
        index = 0
    }
    
    /// Getter for the current ar view
    /// - Returns: The ar view from the databases shared instance
    public func getARView() -> ARView {
        return Database.sharedInstance.arView
    }
    
    /// Adds a new coffee purchase to to the database and saves it on the disk
    /// - Parameter purchase: The coffee purchase to add
    public func addCoffeePurchase(purchase: CoffeePurchase) {
        Database.sharedInstance.coffeePurchases.append(purchase)
        
        saveDataToDisk(coffeePurchases: Database.sharedInstance.coffeePurchases) { result in
            switch result {
            case .failure(let error):
                fatalError(error.localizedDescription)
            case .success(let coffeePurchasesCount):
                print(coffeePurchasesCount)
            }
        }
    }
    
    /// Sets the index to 0 and returns the first coffee purchase from the database
    /// - Returns: The first coffee purchase from the database
    public func getFirstCoffeePurchase() -> CoffeePurchase? {
        index = 0
        
        if Database.sharedInstance.coffeePurchases.isEmpty {
            return nil
        }
        
        return Database.sharedInstance.coffeePurchases[index]
    }
    
    /// Increases the index by 1 and returns the corresponding coffee purchase from the database
    /// - Returns: The next coffee purchase from the database
    public func getNextCoffeePurchase() -> CoffeePurchase? {
        index += 1
        
        if index > Database.sharedInstance.coffeePurchases.count - 1 {
            return nil
        }
        
        return Database.sharedInstance.coffeePurchases[index]
    }
}
