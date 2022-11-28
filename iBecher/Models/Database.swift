//
//  Database.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation

class Database {
    static let sharedInstance = Database()
    
    var allCoffeePurchases: [CoffeePurchase]
    
    init() {
        allCoffeePurchases = []
    }
}
