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
    private var calendar: Calendar
    
    private let numberFormatter: NumberFormatter
    
    init() {
        modelInterface = ModelInterface()
        
        calendar = Calendar(identifier: .gregorian)
        calendar.locale = NSLocale(localeIdentifier: "de_DE") as Locale
        
        coffeePurchases = []
        
        numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "de_DE")
        numberFormatter.numberStyle = .currency
        
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
    
    public func getSummarizedCoffeePurchases(forPeriod: TimePeriod) -> [CoffeePurchases] {
        if coffeePurchases.isEmpty {
            return []
        }
        
        let calendarComponent: Calendar.Component
        
        if forPeriod == .weekly {
            calendarComponent = .weekOfYear
        } else if forPeriod == .monthly {
            calendarComponent = .month
        } else {
            calendarComponent = .year
        }
        
        let filteredCoffeePurchases: [CoffeePurchase]
        
        // only show data of the current year, except the user filters by years
        if calendarComponent == .year {
            filteredCoffeePurchases = coffeePurchases
        } else {
            filteredCoffeePurchases = coffeePurchases.filter { purchase in
                let purchaseYear = calendar.component(.year, from: purchase.date)
                let currentYear = calendar.component(.year, from: Date.now)
                
                return purchaseYear == currentYear
            }
        }
        
        // get the calendar component for every purchase
        let calendarComponents = filteredCoffeePurchases.map { purchase in
            calendar.component(calendarComponent, from: purchase.date)
        }
        
        // remove duplicates
        let uniqueCalendarComponents: [Int] = Array(Set(calendarComponents))
        
        // create weekly purchase for every calendar week
        var coffeePurchasesList: [CoffeePurchases] = []
        
        for calendarComponentValue in uniqueCalendarComponents {
            let title: String
            var usedPaperMugs: Int = 0
            var costsTotal: Double = 0
            
            for purchase in coffeePurchases {
                if calendar.component(calendarComponent, from: purchase.date) == calendarComponentValue {
                    if purchase.mugType == .paperMug {
                        usedPaperMugs += 1
                    }
                    
                    costsTotal += purchase.cost
                }
            }
            
            if forPeriod == .weekly {
                title = "KW \(calendarComponentValue)"
            }
            else if forPeriod == .monthly {
                title = calendar.monthSymbols[calendarComponentValue]
            }
            else {
                title = String(calendarComponentValue)
            }
            
            let costsTotalAsString = numberFormatter.string(from: costsTotal as NSNumber)!
            
            coffeePurchasesList.append(
                CoffeePurchases(
                    title: title,
                    calendarComponentValue: calendarComponentValue,
                    usedPaperMugs: usedPaperMugs,
                    totalDrankCoffee: 0,
                    costsTotal: costsTotalAsString
                )
            )
        }
        
        coffeePurchasesList.sort { (first, second) in
            first.calendarComponentValue < second.calendarComponentValue
        }
        
        return coffeePurchasesList
    }
}
