//
//  CoffeeConsumptionView.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import SwiftUI

struct CoffeeConsumptionView: View {
    @ObservedObject var vm: CoffeeTrackerVM
    @State var period = TimePeriod.weekly
    @Binding var tabViewSelection: TabViewSelection
    
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
            
            if period == .total {
                TotalCoffeePurchasesView(
                    totalCoffeePurchases: vm.getTotalCoffeePurchases()
                )
            } else {
                CoffeePurchasesListView(
                    purchases: vm.getSummarizedCoffeePurchases(forPeriod: period),
                    tabViewSelection: $tabViewSelection
                )
            }
            Spacer()
        }
    }
}

struct CoffeeConsumptionView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeConsumptionView(vm: CoffeeTrackerVM(), tabViewSelection: .constant(.coffeeTracker))
    }
}
