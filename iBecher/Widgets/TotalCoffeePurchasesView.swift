//
//  TotalCoffeePurchases.swift
//  iBecher
//
//  Created by Tim Wagner on 16.01.23.
//

import SwiftUI

struct TotalCoffeePurchasesView: View {
    let totalCoffeePurchases: TotalCoffeePurchases
    
    var body: some View {
        VStack {
            Text("Benutze Pappbecher: \(totalCoffeePurchases.usedPaperMugs)")
            Text("Getrunkener Kaffee: \(totalCoffeePurchases.totalDrankCoffee) Liter")
            Text("Kosten insgesamt: \(totalCoffeePurchases.costsTotal)")
        }
        .padding()
    }
}

struct TotalCoffeePurchases_Previews: PreviewProvider {
    static var previews: some View {
        TotalCoffeePurchasesView(
            totalCoffeePurchases: TotalCoffeePurchases(
                usedPaperMugs: 13,
                totalDrankCoffee: "34",
                costsTotal: "42,35 €"
            )
        )
    }
}
