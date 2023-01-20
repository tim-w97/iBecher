//
//  CoffeeConsumptionView.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import SwiftUI

/// The Coffee Consumption View shows a list of summarized coffee consumptions, filtered by the time period selected by the picker at the top of the screen
struct CoffeeConsumptionView: View {
    @ObservedObject var vm: CoffeeTrackerVM
    /// The time period that is currently selected by the user
    @State var period = TimePeriod.weekly
    /// The tab view selection State gets üassed to jump to the Coffee Tracker if the user hasn't tracked anything yet
    @Binding var tabViewSelection: TabViewSelection
    
    /// The View consists of a picker to choose the time period, followed by the List of summarized coffee purchases
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

/// Preview for the Coffee Consumption Screen
struct CoffeeConsumptionView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeConsumptionView(vm: CoffeeTrackerVM(), tabViewSelection: .constant(.coffeeTracker))
    }
}
