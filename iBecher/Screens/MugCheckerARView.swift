//
//  MugARView.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import SwiftUI

struct MugCheckerARView: View {
    @ObservedObject var vm: MugCheckerVM
    
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

struct MugCheckerARView_Previews: PreviewProvider {
    static var previews: some View {
        MugCheckerARView(vm: MugCheckerVM())
    }
}
