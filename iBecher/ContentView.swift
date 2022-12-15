//
//  ContentView.swift
//  iBecher
//
//  Created by Tim Wagner on 27.11.22.
//

import SwiftUI

struct ContentView: View {
    @State var tabViewSelection = 1
    
    var body: some View {
        TabView(selection: $tabViewSelection){
            MugCheckerARView()
                .tabItem {
                    Label("Tasse überprüfen", systemImage: "wand.and.stars")
                }.tag(0)
            
            CoffeeTrackerView(vm: CoffeeTrackerVM())
                .tabItem {
                    Label("Tracker", systemImage: "clock.fill")
                }.tag(1)
            
            CoffeeConsumptionView()
                .tabItem {
                    Label("Kaffeekonsum", systemImage: "mug.fill")
                }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
