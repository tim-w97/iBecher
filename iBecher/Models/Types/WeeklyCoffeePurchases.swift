//
//  WeeklyConsumption.swift
//  iBecher
//
//  Created by Tim Wagner on 13.01.23.
//

import Foundation

struct WeeklyCoffeePurchases: Identifiable {
    let calendarWeek: Int
    let usedPaperMugs: Int
    let totalDrankCoffee: Int
    let costsTotal: Double
    
    // use the calendar week as id
    var id: Int {
        calendarWeek
    }
}
