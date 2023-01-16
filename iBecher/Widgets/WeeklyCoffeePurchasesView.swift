//
//  WeeklyCoffeePurchases.swift
//  iBecher
//
//  Created by Tim Wagner on 13.01.23.
//

import SwiftUI

struct WeeklyCoffeePurchasesView: View {
    let purchases: [CoffeePurchases]
    
    init(purchases: [CoffeePurchases]) {
        self.purchases = purchases
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(purchases) { purchase in
                    Card {
                        VStack {
                            HStack {
                                Image(systemName: "calendar")
                                    .foregroundColor(.blue)
                                Text("\(purchase.calendarComponentValue)")
                            }.padding()
                            
                            Divider()
                            
                            VStack {
                                Text("Benutze Pappbecher: \(purchase.usedPaperMugs)")
                                Text("Getrunkener Kaffee: \(purchase.totalDrankCoffee) Liter")
                                Text("Kosten insgesamt: \(String(format: "%.02f", purchase.costsTotal)) €")
                            }.padding()
                        }
                    }.padding(.bottom)
                }
            }.padding()
        }
    }
}

struct WeeklyCoffeePurchases_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyCoffeePurchasesView(purchases: [
            CoffeePurchases(
                calendarComponentValue: 2,
                usedPaperMugs: 12,
                totalDrankCoffee: 4,
                costsTotal: 23.5
            ),
            CoffeePurchases(
                calendarComponentValue: 3,
                usedPaperMugs: 2,
                totalDrankCoffee: 6,
                costsTotal: 25.3
            ),
            CoffeePurchases(
                calendarComponentValue: 3,
                usedPaperMugs: 2,
                totalDrankCoffee: 6,
                costsTotal: 25.3
            )
        ])
    }
}
