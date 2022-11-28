//
//  CoffeeConsumptionView.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import SwiftUI

struct CoffeeConsumptionView: View {
    @State var period = "Woche"
    
    var body: some View {
        Picker("Zeitraum", selection: $period) {
            Text("Woche")
            Text("Monat")
            Text("Jahr")
            Text("Insgesamt")
        }
        .pickerStyle(.wheel)
    }
}

struct CoffeeConsumptionView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeConsumptionView()
    }
}
