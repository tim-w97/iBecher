//
//  MugTypeSwitch.swift
//  iBecher
//
//  Created by Tim Wagner on 09.12.22.
//

import SwiftUI

struct MugTypeToggle: View {
    @ObservedObject var vm: CoffeeTrackerVM
    
    @State var toggleValue = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(vm.selectedMugType == .reusableMug ? .green : .gray, lineWidth: 8)
            
            Toggle(vm.selectedMugType == .reusableMug ? "Ja! 😍" : "Nein. 😔", isOn: $toggleValue)
                .onChange(of: toggleValue) { newToggleValue in
                    vm.toggleMugType(toggleValue: newToggleValue)
                }
                .padding()
        }
        .frame(width: 170, height: 100)
    }
}

struct MugTypeSwitch_Previews: PreviewProvider {
    static var previews: some View {
        MugTypeToggle(vm: CoffeeTrackerVM())
    }
}
