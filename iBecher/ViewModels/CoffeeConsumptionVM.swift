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
    
    public func getWeeklyCoffeePurchases() -> [WeeklyCoffeePurchases] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = NSLocale(localeIdentifier: "de_DE") as Locale
        
        // get the calendar week for every purchase
        let calendarWeeks = coffeePurchases.map { purchase in
            calendar.component(.weekOfYear, from: purchase.date)
        }
        
        // remove duplicates
        let uniqueCalendarWeeks: [Int] = Array(Set(calendarWeeks))
        
        // create weekly purchase for every calendar week
        var weeklyCoffeePurchasesList: [WeeklyCoffeePurchases] = []
        
        for calendarWeek in uniqueCalendarWeeks {
            var usedPaperMugs: Int = 0
            var costsTotal: Double = 0
            
            for purchase in coffeePurchases {
                if calendar.component(.weekOfYear, from: purchase.date) == calendarWeek {
                    if purchase.mugType == .paperMug {
                        usedPaperMugs += 1
                    }
                    
                    costsTotal += purchase.cost
                }
            }
            
            weeklyCoffeePurchasesList.append(
                WeeklyCoffeePurchases(
                    calendarWeek: calendarWeek,
                    usedPaperMugs: usedPaperMugs,
                    totalDrankCoffee: 0,
                    costsTotal: costsTotal
                )
            )
        }
        
        weeklyCoffeePurchasesList.sort {
            $0.calendarWeek < $1.calendarWeek
        }
        
        return weeklyCoffeePurchasesList
    }
    
    public func getMonthlyCoffeePurchases() -> [MonthlyCoffeePurchases] {
        return []
    }
    
    public func getYearlyCoffeePurchases() -> [YearlyCoffeePurchases] {
        return []
    }
}
