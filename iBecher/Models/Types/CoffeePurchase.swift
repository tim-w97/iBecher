//
//  CoffeePurchase.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation

/// Stores the purchase date, the coffee size and the mug type (paper mug / reusable mug)
struct CoffeePurchase: Identifiable, Codable {
    var id = UUID()
    
    let date: Date
    let size: CoffeeSize
    let mugType: MugType
}
