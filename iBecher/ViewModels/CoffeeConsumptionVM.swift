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
    
    init() {
        modelInterface = ModelInterface()
        
        calendar = Calendar(identifier: .gregorian)
        calendar.locale = NSLocale(localeIdentifier: "de_DE") as Locale
        
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
    
    public func getSummarizedCoffeePurchases(forPeriod: TimePeriod) -> [CoffeePurchases] {
        let calendarComponent: Calendar.Component
        
        if forPeriod == .weekly {
            calendarComponent = .weekOfYear
        } else if forPeriod == .monthly {
            calendarComponent = .month
        } else {
            calendarComponent = .year
        }
        
        // get the calendar component for every purchase
        let calendarComponents = coffeePurchases.map { purchase in
            calendar.component(calendarComponent, from: purchase.date)
        }
        
        // remove duplicates
        let uniqueCalendarComponents: [Int] = Array(Set(calendarComponents))
        
        // create weekly purchase for every calendar week
        var coffeePurchasesList: [CoffeePurchases] = []
        
        for calendarComponentValue in uniqueCalendarComponents {
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
            
            coffeePurchasesList.append(
                CoffeePurchases(
                    calendarComponentValue: calendarComponentValue,
                    usedPaperMugs: usedPaperMugs,
                    totalDrankCoffee: 0,
                    costsTotal: costsTotal
                )
            )
        }
        
        coffeePurchasesList.sort { (first, second) in
            first.calendarComponentValue < second.calendarComponentValue
        }
        
        return coffeePurchasesList
    }
}
