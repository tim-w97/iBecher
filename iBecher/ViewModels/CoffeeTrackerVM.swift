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
    
    let currencyFormatter: NumberFormatter
    let numberFormatter: NumberFormatter
    
    init() {
        modelInterface = ModelInterface()
        
        coffeePurchases = []
        
        calendar = Calendar(identifier: .gregorian)
        calendar.locale = NSLocale(localeIdentifier: "de_DE") as Locale
        
        selectedCoffeeSize = .small
        
        selectedMugType = .paperMug
        
        cost = 0
        
        currencyFormatter = NumberFormatter()
        currencyFormatter.locale = Locale(identifier: "de_DE")
        currencyFormatter.numberStyle = .currency
        
        numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "de_DE")
        numberFormatter.numberStyle = .decimal
        
        loadDataFromDisk()
        
        calculateCoffeePrice()
    }
    
    func getCostAsString() -> String {
        return currencyFormatter.string(from: cost as NSNumber)!
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
            mugType: selectedMugType
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
            
            if purchase.size == .small {
                totalDrankCoffee += CoffeeAmount.small
            }
            if purchase.size == .big {
                totalDrankCoffee += CoffeeAmount.big
            }
            
            costsTotal += calculateCoffeePrice(forPurchase: purchase)
        }
        
        return TotalCoffeePurchases(
            usedPaperMugs: usedPaperMugs,
            totalDrankCoffee: numberFormatter.string(from: totalDrankCoffee as NSNumber)!,
            costsTotal: currencyFormatter.string(from: costsTotal as NSNumber)!
        )
    }
    
    func calculateCoffeePrice(forPurchase:CoffeePurchase) -> Double {
        var cost:Double = 0
        
        if forPurchase.size == .small {
            cost += CoffeePrice.small
        }
        if forPurchase.size == .big {
            cost += CoffeePrice.big
        }
        
        if forPurchase.mugType == .paperMug {
            cost += CoffeePrice.paperMug
        }
        
        return cost
    }
    
    func calculateCoffeePrice() {
        cost = 0
        
        if selectedCoffeeSize == .small {
            cost += CoffeePrice.small
        }
        if selectedCoffeeSize == .big {
            cost += CoffeePrice.big
        }
        
        if selectedMugType == .paperMug {
            cost += CoffeePrice.paperMug
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
