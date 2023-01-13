//
//  CoffeeConsumptionVM.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation

class CoffeeConsumptionVM: ObservableObject {
    @Published var coffeePurchases: [CoffeePurchase]
    
    private let modelInterface: ModelInterface
    
    init() {
        modelInterface = ModelInterface()
        
        coffeePurchases = []
        loadCoffeePurchases()
    }
    
    public func loadCoffeePurchases() {
        coffeePurchases = []
        
        var purchase = modelInterface.getFirstCoffeePurchase()
        
        if purchase == nil {
            return
        }
        
        while purchase != nil {
            coffeePurchases.append(purchase!)
            purchase = modelInterface.getNextCoffeePurchase()
        }
    }
}
