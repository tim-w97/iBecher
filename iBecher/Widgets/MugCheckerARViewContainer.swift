//
//  MugCheckerARViewContainer.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation
import RealityKit
import SwiftUI

struct MugCheckerARViewContainer: UIViewRepresentable {
    let vm: MugCheckerVM
    
    func makeUIView(context: Context) -> some UIView {
        return vm.arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // nothing is happening here
    }
}
