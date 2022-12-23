//
//  MugCheckerVM.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation
import RealityKit

class MugCheckerVM : ObservableObject {
    let arView: ARView
    
    init() {
        arView = Database.sharedInstance.arView
    }
}
