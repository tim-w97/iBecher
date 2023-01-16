//
//  CoffeeTrackerVM.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation

class CoffeeTrackerVM: ObservableObject {
    private let modelInterface: ModelInterface
    
    @Published var selectedCoffeeSize: CoffeeSize
    @Published var selectedMugType: MugType
    
    @Published var cost: Double
    
    let numberFormatter: NumberFormatter
    
    init() {
        modelInterface = ModelInterface()
        selectedCoffeeSize = .small
        
        selectedMugType = .paperMug
        
        cost = 0
        
        numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "de_DE")
        numberFormatter.numberStyle = .currency
        
        calculateCoffeePrice()
    }
    
    func getCostAsString() -> String {
        return numberFormatter.string(from: cost as NSNumber)!
    }
    
    func selectSmallCoffeeSize() {
        selectedCoffeeSize = .small
        calculateCoffeePrice()
    }
    
    func selectBigCoffeeSize() {
        selectedCoffeeSize = .big
        calculateCoffeePrice()
    }
    
    func toggleMugType(toggleValue: Bool) {
        selectedMugType = toggleValue ? .reusableMug : .paperMug
        calculateCoffeePrice()
    }
    
    func addCoffeePurchase() {
        let purchase = CoffeePurchase (
            id: UUID(),
            date: Date.now,
            size: selectedCoffeeSize,
            mugType: selectedMugType,
            cost: cost
        )
        
        modelInterface.addCoffeePurchase(purchase: purchase)
    }
    
    private func calculateCoffeePrice() {
        cost = 0
        
        if selectedCoffeeSize == .small {
            cost += 0.70
        } else {
            cost += 1.00
        }
        
        if selectedMugType == .paperMug {
            cost += 0.15
        }
    }
}
