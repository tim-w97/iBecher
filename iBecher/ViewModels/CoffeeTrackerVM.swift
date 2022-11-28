//
//  CoffeeTrackerVM.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation

class CoffeeTrackerVM: ObservableObject {
    private let modelInterface: ModelInterface
    
    init() {
        modelInterface = ModelInterface()
    }
}