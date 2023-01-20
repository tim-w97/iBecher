//
//  MugARView.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import SwiftUI

/// This screen stacks the ar view with some UI controls
struct MugCheckerARView: View {
    @ObservedObject var vm: MugCheckerVM
    
    /// The view consists of the ar view, stacked with a slider to change the top lid height, a text with the current height and a text that shows wether the mug is too tall or not
    var body: some View {
        let topText: String = vm.lidIsOverMaxCupHeight ?
        "Deine Tasse ist zu groß. 😥" :
        "Deine Tasse passt in den Automaten! 🍀"
        
        ZStack {
            MugCheckerARViewContainer(vm: vm)
            
            VStack {
                Text(topText).multilineTextAlignment(.center)
                
                Spacer()
                
                Slider(
                    value: $vm.topLidHeight,
                    in: vm.minTopLidHeight...vm.maxTopLidHeight,
                    step: vm.topLidHeightSliderStep
                ) {}
                
                Text("Höhe: \(Int(vm.topLidHeight)) cm")
            }.padding()
        }
    }
}

/// Preview for the Mug Checker AR Screen
struct MugCheckerARView_Previews: PreviewProvider {
    static var previews: some View {
        MugCheckerARView(vm: MugCheckerVM())
    }
}
