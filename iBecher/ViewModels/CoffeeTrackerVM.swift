//
//  CoffeeConsumptionVM.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation

/// Holds the current data on the Coffee Tracker Screen and adds it to the database if the user taps the button
class CoffeeTrackerVM: ObservableObject {
    @Published var coffeePurchases: [CoffeePurchase]
    
    @Published var selectedCoffeeSize: CoffeeSize
    @Published var selectedMugType: MugType
    @Published var cost: Double
    
    private let modelInterface: ModelInterface
    var calendar: Calendar
    
    let currencyFormatter: NumberFormatter
    let numberFormatter: NumberFormatter
    
    /// Initializes all attributes, creates two number formatters for currency and numbers and loads the coffee purchases from the disk
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
    
    /// Converts the current cost to a currency string
    /// - Returns: Formatted currency value
    func getCostAsString() -> String {
        return currencyFormatter.string(from: cost as NSNumber)!
    }
    
    /// Selects the small coffee size and recalculates the coffee price
    func selectSmallCoffeeSize() {
        selectedCoffeeSize = .small
        calculateCoffeePrice()
    }
    
    /// Selects the big coffee size and recalculates the coffee price
    func selectBigCoffeeSize() {
        selectedCoffeeSize = .big
        calculateCoffeePrice()
    }
    
    /// Toggles the mug type from resusableMug to paperMug or vice versa and recalculates the coffee price
    /// - Parameter toggleValue: The new value of the toggle switch
    func toggleMugType(toggleValue: Bool) {
        selectedMugType = toggleValue ? .reusableMug : .paperMug
        calculateCoffeePrice()
    }
    
    /// Creates  a new coffee purchase  from the selected values, adds the current date and saves it on the disk
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
    
    /// Calculates the total values for each coffee purchase
    /// - Returns: The total coffee purchases
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
    
    /// Calculates the price for a given coffee purchase
    /// - Parameter forPurchase: The purchase to calculate the price of
    /// - Returns: The  calculated price of the coffee purchase
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
    
    /// Calculates the price of the selected coffee purchase on the screen
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
    
    /// Reloads all coffee purchases from the database and shows it on the screen
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
    
    /// Loads all coffee purchases from the disk and stores it in the database
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
