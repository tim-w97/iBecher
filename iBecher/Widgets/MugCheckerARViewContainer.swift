//
//  MugCheckerARViewContainer.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation
import RealityKit
import SwiftUI

/// The AR view is based on UIKit, so we need to wrap it with a UIViewRepresentable to use it in SwiftUI views
struct MugCheckerARViewContainer: UIViewRepresentable {
    let vm: MugCheckerVM
    
    func makeUIView(context: Context) -> some UIView {
        return vm.arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // nothing is happening here
    }
}
