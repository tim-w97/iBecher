//
//  WeeklyCoffeePurchases.swift
//  iBecher
//
//  Created by Tim Wagner on 13.01.23.
//

import SwiftUI

struct CoffeePurchasesListView: View {
    let purchases: [CoffeePurchases]
    @Binding var tabViewSelection: TabViewSelection
    
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


struct CoffeePurchasesListView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeePurchasesListView(purchases: [
            CoffeePurchases(
                title: "Test 123",
                calendarComponentValue: 2,
                usedPaperMugs: 12,
                totalDrankCoffee: 4,
                costsTotal: "6,50 €"
            ),
            CoffeePurchases(
                title: "Test 123",
                calendarComponentValue: 3,
                usedPaperMugs: 2,
                totalDrankCoffee: 6,
                costsTotal: "6,50 €"
            ),
            CoffeePurchases(
                title: "Test 123",
                calendarComponentValue: 3,
                usedPaperMugs: 2,
                totalDrankCoffee: 6,
                costsTotal: "6,50 €"
            )
        ],
        tabViewSelection: .constant(.coffeeTracker)
        )
    }
}
