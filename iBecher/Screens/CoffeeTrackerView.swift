//
//  CoffeeTrackerView.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import SwiftUI

struct CoffeeTrackerView: View {
    @ObservedObject var vm: CoffeeTrackerVM
    @Binding var tabViewSelection: TabViewSelection
    
    @State var alertIsShown = false
    
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
                    mugType: $vm.selectedMugType
                ) {
                    vm.selectSmallCoffeeSize()
                }.padding()
                
                MugButton(
                    coffeeSize: .big,
                    selectedCoffeeSize: $vm.selectedCoffeeSize,
                    mugType: $vm.selectedMugType
                ) {
                    vm.selectBigCoffeeSize()
                }.padding()
            }
            
            Spacer()
            
            HStack {
                Text("Kosten:")
                Text(vm.getCostAsString()).font(.largeTitle)
            }
            
            Button("Hinzufügen") {
                vm.addCoffeePurchase()
                alertIsShown = true
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .alert("Kaffee wurde hinzugefügt. 🥳", isPresented: $alertIsShown) {
                Button("Kaffeekonsum anzeigen"){
                    tabViewSelection = .coffeeConsumption
                    alertIsShown = false
                }
                Button("Schließen"){
                    alertIsShown = false
                }
            }
        }
    }
}

struct CoffeeTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeTrackerView(
            vm: CoffeeTrackerVM(),
            tabViewSelection: .constant(.coffeeTracker)
        )
    }
}
