//
//  ContentView.swift
//  iBecher
//
//  Created by Tim Wagner on 27.11.22.
//

import SwiftUI

struct ContentView: View {
    @State var tabViewSelection = TabViewSelection.coffeeTracker
    
    let coffeeTrackerVM = CoffeeTrackerVM()
    
    var body: some View {
        TabView(selection: $tabViewSelection){
            MugCheckerARView(
                vm: MugCheckerVM()
            )
            .tabItem {
                Label("Tasse überprüfen", systemImage: "wand.and.stars")
            }
            .tag(TabViewSelection.mugChecker)
            
            CoffeeTrackerView(
                vm: coffeeTrackerVM,
                tabViewSelection: $tabViewSelection
            )
            .tabItem {
                Label("Tracker", systemImage: "clock.fill")
            }
            .tag(TabViewSelection.coffeeTracker)
            
            CoffeeConsumptionView(
                vm: coffeeTrackerVM,
                tabViewSelection: $tabViewSelection
            )
            .tabItem {
                Label("Kaffeekonsum", systemImage: "mug.fill")
            }
            .tag(TabViewSelection.coffeeConsumption)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
