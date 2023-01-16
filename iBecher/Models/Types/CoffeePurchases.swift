//
//  WeeklyConsumption.swift
//  iBecher
//
//  Created by Tim Wagner on 13.01.23.
//

import Foundation

struct CoffeePurchases: Identifiable {
    let title: String
    let calendarComponentValue: Int
    let usedPaperMugs: Int
    let totalDrankCoffee: Int
    let costsTotal: String
    
    // use the calendar component value as id
    var id: Int {
        calendarComponentValue
    }
}
