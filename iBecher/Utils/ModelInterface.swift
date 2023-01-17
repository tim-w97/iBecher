//
//  ModelInterface.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation
import RealityKit

class ModelInterface {
    var index: Int
    
    init() {
        index = 0
    }
    
    public func getARView() -> ARView {
        return Database.sharedInstance.arView
    }
    
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
    
    public func getFirstCoffeePurchase() -> CoffeePurchase? {
        index = 0
        
        if Database.sharedInstance.coffeePurchases.isEmpty {
            return nil
        }
        
        return Database.sharedInstance.coffeePurchases[index]
    }
    
    public func getNextCoffeePurchase() -> CoffeePurchase? {
        index += 1
        
        if index > Database.sharedInstance.coffeePurchases.count - 1 {
            return nil
        }
        
        return Database.sharedInstance.coffeePurchases[index]
    }
}
