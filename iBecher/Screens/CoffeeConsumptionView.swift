//
//  CoffeeConsumptionView.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import SwiftUI

struct CoffeeConsumptionView: View {
    @ObservedObject var vm: CoffeeConsumptionVM
    @State var period = TimeInterval.weekly
    
    var body: some View {
        VStack(spacing: 0) {
            if period == .weekly {
                WeeklyCoffeePurchasesView(
                    purchases: vm.getWeeklyCoffeePurchases()
                )
            } else {
                Spacer()
            }
            
            Rectangle()
                .fill(.blue)
                .frame(height: 3)
            
            Picker("Zeitraum", selection: $period) {
                Text("Wöchentlich").tag(TimeInterval.weekly)
                Text("Monatlich").tag(TimeInterval.monthly)
                Text("Jährlich").tag(TimeInterval.yearly)
                Text("Insgesamt").tag(TimeInterval.total)
            }.pickerStyle(.wheel)
        }
        .onAppear {
            vm.loadCoffeePurchases()
        }
    }
}

struct CoffeeConsumptionView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeConsumptionView(vm: CoffeeConsumptionVM())
    }
}
