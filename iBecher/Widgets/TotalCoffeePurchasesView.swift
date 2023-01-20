//
//  TotalCoffeePurchases.swift
//  iBecher
//
//  Created by Tim Wagner on 16.01.23.
//

import SwiftUI

/// This view shows the totals of all coffee purchases made by the user
struct TotalCoffeePurchasesView: View {
    let totalCoffeePurchases: TotalCoffeePurchases
    
    /// Vertical list of the totals of paper mugs used, coffee drunk  and costs
    var body: some View {
        VStack {
            Text("Benutze Pappbecher: \(totalCoffeePurchases.usedPaperMugs)")
            Text("Getrunkener Kaffee: \(totalCoffeePurchases.totalDrankCoffee) Liter")
            Text("Kosten insgesamt: \(totalCoffeePurchases.costsTotal)")
        }
        .padding()
    }
}

/// Preview of the Total Coffee Purchases View
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
