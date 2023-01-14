//
//  YearlyConsumption.swift
//  iBecher
//
//  Created by Tim Wagner on 13.01.23.
//

import Foundation

struct YearlyCoffeePurchases: Identifiable {
    let year: Int
    let usedPaperMugs: Int
    let totalDrankCoffee: Int
    let costsTotal: Double
    
    // use the year as id
    var id: Int {
        year
    }
}
