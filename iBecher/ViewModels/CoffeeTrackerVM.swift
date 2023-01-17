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
        
        coffeePurchases = []
        
        calendar = Calendar(identifier: .gregorian)
        calendar.locale = NSLocale(localeIdentifier: "de_DE") as Locale
        
        selectedCoffeeSize = .small
        
        selectedMugType = .paperMug
        
        cost = 0
        
        numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "de_DE")
        numberFormatter.numberStyle = .currency
        
        loadDataFromDisk()
        
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
        
        refreshCoffeePurchasesList()
    }
    
    func getTotalCoffeePurchases() -> TotalCoffeePurchases {
        var usedPaperMugs: Int = 0
        var totalDrankCoffee: Double = 0
        var costsTotal: Double = 0
        
        for purchase in coffeePurchases {
            if purchase.mugType == .paperMug {
                usedPaperMugs += 1
            }
            
            costsTotal += purchase.cost
        }
        
        return TotalCoffeePurchases(
            usedPaperMugs: usedPaperMugs,
            totalDrankCoffee: String(totalDrankCoffee),
            costsTotal: numberFormatter.string(from: costsTotal as NSNumber)!
        )
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
    
    public func refreshCoffeePurchasesList() {
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
    
    func loadDataFromDisk() {
        modelInterface.loadDataFromDisk { result in
            switch result {
                
            case .failure(let error):
                fatalError(error.localizedDescription)
                
            case .success(let coffeePurchases):
                Database.sharedInstance.coffeePurchases = coffeePurchases
                self.refreshCoffeePurchasesList()
            }
        }
    }
}
