//
//  ContentView.swift
//  iBecher
//
//  Created by Tim Wagner on 27.11.22.
//

import SwiftUI

/// The Content View shows a tab view that encloses all the screens the user can see
struct ContentView: View {
    /// The current tab that is active
    @State var tabViewSelection = TabViewSelection.coffeeTracker
    
    let coffeeTrackerVM = CoffeeTrackerVM()
    
    /// The Tab Views allows the user to switch between Mug Checker, Coffee Tracker and Coffee Consumption
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

/// Preview of the App's Content View
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
