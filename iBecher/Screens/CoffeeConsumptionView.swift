//
//  CoffeeConsumptionView.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import SwiftUI

struct CoffeeConsumptionView: View {
    @ObservedObject var vm: CoffeeConsumptionVM
    @State var period = TimePeriod.weekly
    @Binding var tabViewSelection: Int
    
    var body: some View {
        VStack(spacing: 0) {
            Picker("Zeitraum", selection: $period) {
                Text("Wöchentlich")
                    .tag(TimePeriod.weekly)
                Text("Monatlich")
                    .tag(TimePeriod.monthly)
                Text("Jährlich")
                    .tag(TimePeriod.yearly)
                Text("Insgesamt")
                    .tag(TimePeriod.total)
            }
            .pickerStyle(.segmented)
            .padding()
            
            Divider()
            
            CoffeePurchasesListView(
                purchases: vm.getSummarizedCoffeePurchases(forPeriod: period),
                tabViewSelection: $tabViewSelection
            )
        }
        .onAppear {
            vm.loadCoffeePurchases()
        }
    }
}

struct CoffeeConsumptionView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeConsumptionView(vm: CoffeeConsumptionVM(), tabViewSelection: .constant(1))
    }
}
