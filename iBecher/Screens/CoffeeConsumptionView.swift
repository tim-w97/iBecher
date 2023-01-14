//
//  CoffeeConsumptionView.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import SwiftUI

struct CoffeeConsumptionView: View {
    @ObservedObject var vm: CoffeeConsumptionVM
    @State var period = "Woche"
    
    var body: some View {
        VStack {
            WeeklyCoffeePurchasesView(
                purchases: vm.getWeeklyCoffeePurchases()
            )
            
            Picker("Zeitraum", selection: $period) {
                Text("Wöchentlich")
                Text("Monatlich")
                Text("Jährlich")
                Text("Insgesamt")
            }.pickerStyle(.wheel)
        }.onAppear {
            vm.loadCoffeePurchases()
        }
    }
}

struct CoffeeConsumptionView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeConsumptionView(vm: CoffeeConsumptionVM())
    }
}
