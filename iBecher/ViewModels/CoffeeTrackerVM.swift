//
//  CoffeeTrackerVM.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation

class CoffeeTrackerVM: ObservableObject {
    private let modelInterface: ModelInterface
    
    @Published var selectedCoffeeSize: CoffeeSize
    @Published var price: Double
    
    @Published var mugTypeToggleValue: Bool {
        didSet {
            calculateCoffeePrice()
        }
    }
    
    init() {
        modelInterface = ModelInterface()
        selectedCoffeeSize = .small
        mugTypeToggleValue = false
        price = 0
        
        calculateCoffeePrice()
    }
    
    func selectSmallCoffeeSize() {
        selectedCoffeeSize = .small
        calculateCoffeePrice()
    }
    
    func selectBigCoffeeSize() {
        selectedCoffeeSize = .big
        calculateCoffeePrice()
    }
    
    private func calculateCoffeePrice() {
        price = 0
        
        if selectedCoffeeSize == .small {
            price += 0.70
        } else {
            price += 1.00
        }
        
        if mugTypeToggleValue == false {
            price += 0.15
        }
    }
}
