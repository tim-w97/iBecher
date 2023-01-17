//
//  CoffeeConsumptionVM.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation

class CoffeeTrackerVM: ObservableObject {
    @Published var coffeePurchases: [CoffeePurchase]
    
    @Published var selectedCoffeeSize: CoffeeSize
    @Published var selectedMugType: MugType
    @Published var cost: Double
    
    private let modelInterface: ModelInterface
    var calendar: Calendar
    
    let numberFormatter: NumberFormatter
    
    init() {
        modelInterface = ModelInterface()
        
        calendar = Calendar(identifier: .gregorian)
        calendar.locale = NSLocale(localeIdentifier: "de_DE") as Locale
        
        coffeePurchases = []
        
        selectedCoffeeSize = .small
        
        selectedMugType = .paperMug
        
        cost = 0
        
        numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "de_DE")
        numberFormatter.numberStyle = .currency
        
        loadCoffeePurchases()
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
        
        loadCoffeePurchases()
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
