//
//  WeeklyCoffeePurchases.swift
//  iBecher
//
//  Created by Tim Wagner on 13.01.23.
//

import SwiftUI

/// Shows a list of summarized coffee purchases
struct CoffeePurchasesListView: View {
    let purchases: [CoffeePurchases]
    /// The tab view selection State gets üassed to jump to the Coffee Tracker if the user hasn't tracked anything yet
    @Binding var tabViewSelection: TabViewSelection
    
    /// The list shows a info message if the user hasn't tracked anything yet, otherwise it shows a scrollable list of summarized coffee purchases
    var body: some View {
        if purchases.isEmpty {
            VStack {
                Text("Du hast dieses Jahr noch nichts getrackt. 😪")
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button("Jetzt tracken"){
                    tabViewSelection = .coffeeTracker
                }
                .padding()
            }
        }
        
        ScrollView {
            VStack(spacing: 0) {
                ForEach(purchases) { purchase in
                    Card {
                        VStack {
                            HStack {
                                Image(systemName: "calendar")
                                    .foregroundColor(.blue)
                                Text(purchase.title)
                            }.padding()
                            
                            Divider()
                            
                            VStack {
                                Text("Benutze Pappbecher: \(purchase.usedPaperMugs)")
                                Text("Getrunkener Kaffee: \(purchase.totalDrankCoffee) Liter")
                                Text("Kosten insgesamt: \(purchase.costsTotal)")
                            }.padding()
                        }
                    }.padding(.bottom)
                }
            }.padding()
        }
    }
}


/// Preview for the Coffee Purchases List View
struct CoffeePurchasesListView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeePurchasesListView(purchases: [
            CoffeePurchases(
                title: "Test 123",
                calendarComponentValue: 2,
                usedPaperMugs: 12,
                totalDrankCoffee: "42",
                costsTotal: "6,50 €"
            ),
            CoffeePurchases(
                title: "Test 123",
                calendarComponentValue: 3,
                usedPaperMugs: 2,
                totalDrankCoffee: "42",
                costsTotal: "6,50 €"
            ),
            CoffeePurchases(
                title: "Test 123",
                calendarComponentValue: 3,
                usedPaperMugs: 2,
                totalDrankCoffee: "42",
                costsTotal: "6,50 €"
            )
        ],
        tabViewSelection: .constant(.coffeeTracker)
        )
    }
}
