//
//  MonthlyConsumption.swift
//  iBecher
//
//  Created by Tim Wagner on 13.01.23.
//

import Foundation

struct MonthlyCoffeePurchases: Identifiable {
    let month: String
    let usedPaperMugs: Int
    let totalDrankCoffee: Int
    let costsTotal: Double
    
    // use the month as id
    var id: String {
        month
    }
}
