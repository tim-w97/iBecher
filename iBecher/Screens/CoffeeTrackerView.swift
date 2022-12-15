//
//  CoffeeTrackerView.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import SwiftUI

struct CoffeeTrackerView: View {
    @ObservedObject var vm: CoffeeTrackerVM
    
    init(vm: CoffeeTrackerVM) {
        self.vm = vm
    }
    
    var body: some View {
        VStack {
            Text("Hast du eine eigene Tasse dabei?")
                .padding()
            
            MugTypeToggle(vm: vm)
            
            Spacer()
            
            Text("Welche Füllmenge?")
            
            HStack {
                MugButton(
                    coffeeSize: .small,
                    selectedCoffeeSize: $vm.selectedCoffeeSize,
                    mugType: $vm.mugType
                ) {
                        vm.selectSmallCoffeeSize()
                    }.padding()
                
                MugButton(
                    coffeeSize: .big,
                    selectedCoffeeSize: $vm.selectedCoffeeSize,
                    mugType: $vm.mugType
                ) {
                        vm.selectBigCoffeeSize()
                    }.padding()
            }
            
            Spacer()
            
            HStack {
                Text("Kosten:")
                Text("\(String(format: "%.02f", vm.price)) €").font(.largeTitle)
            }
            
            Button("Hinzufügen") {}
                .buttonStyle(.borderedProminent)
                .padding()
        }
    }
}

struct CoffeeTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeTrackerView(vm: CoffeeTrackerVM())
    }
}
