//
//  CoffeeTrackerVM+SummarizedCoffeePurchases.swift
//  iBecher
//
//  Created by Tim Wagner on 17.01.23.
//

import Foundation

extension CoffeeTrackerVM {
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
        
        // create a list of summarized coffee purchases
        var coffeePurchasesList: [CoffeePurchases] = []
        
        for calendarComponentValue in uniqueCalendarComponents {
            let title: String
            var usedPaperMugs: Int = 0
            var costsTotal: Double = 0
            var totalDrankCoffee: Double = 0
            
            for purchase in coffeePurchases {
                if calendar.component(calendarComponent, from: purchase.date) == calendarComponentValue {
                    if purchase.mugType == .paperMug {
                        usedPaperMugs += 1
                    }
                    
                    costsTotal += calculateCoffeePrice(forPurchase: purchase)
                    
                    if purchase.size == .small {
                        totalDrankCoffee += CoffeeAmount.small
                    }
                    if purchase.size == .big {
                        totalDrankCoffee += CoffeeAmount.big
                    }
                    
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
            
            let costsTotalAsString = currencyFormatter.string(from: costsTotal as NSNumber)!
            let totalDrankCoffeeAsString = numberFormatter.string(from: totalDrankCoffee as NSNumber)!
            
            coffeePurchasesList.append(
                CoffeePurchases(
                    title: title,
                    calendarComponentValue: calendarComponentValue,
                    usedPaperMugs: usedPaperMugs,
                    totalDrankCoffee: totalDrankCoffeeAsString,
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
