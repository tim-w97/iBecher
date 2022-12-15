//
//  MugTypeSwitch.swift
//  iBecher
//
//  Created by Tim Wagner on 09.12.22.
//

import SwiftUI

struct MugTypeToggle: View {
    @ObservedObject var vm: CoffeeTrackerVM
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20).stroke(vm.mugTypeToggleValue ? .green : .gray, lineWidth: 8)
            
            Toggle(vm.mugTypeToggleValue ? "Ja! 😍" : "Nein. 😔", isOn: $vm.mugTypeToggleValue)
                .padding()
        }
        .frame(width: 170, height: 100)
        .onTapGesture {
            vm.mugTypeToggleValue.toggle()
        }
    }
}

struct MugTypeSwitch_Previews: PreviewProvider {
    static var previews: some View {
        MugTypeToggle(vm: CoffeeTrackerVM())
    }
}
