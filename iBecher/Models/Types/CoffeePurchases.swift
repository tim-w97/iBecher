//
//  WeeklyConsumption.swift
//  iBecher
//
//  Created by Tim Wagner on 13.01.23.
//

import Foundation

struct CoffeePurchases: Identifiable {
    let calendarComponentValue: Int
    let usedPaperMugs: Int
    let totalDrankCoffee: Int
    let costsTotal: Double
    
    // use the calendar component value as id
    var id: Int {
        calendarComponentValue
    }
}
