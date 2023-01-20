//
//  WeeklyConsumption.swift
//  iBecher
//
//  Created by Tim Wagner on 13.01.23.
//

import Foundation

/// Summary of multiple coffee purchases with total values
struct CoffeePurchases: Identifiable {
    let title: String
    /// the calendar component value holds the value depending on the selected time period on the screen, for example **42** for KW 42, **3** for March, **2023** for Year 2023
    let calendarComponentValue: Int
    let usedPaperMugs: Int
    let totalDrankCoffee: String
    let costsTotal: String
    
    // use the calendar component value as id
    var id: Int {
        calendarComponentValue
    }
}
