//
//  CoffeePurchase.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation

struct CoffeePurchase: Identifiable, Codable {
    var id = UUID()
    
    let date: Date
    let size: CoffeeSize
    let mugType: MugType
    let cost: Double
}
