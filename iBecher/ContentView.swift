//
//  ContentView.swift
//  iBecher
//
//  Created by Tim Wagner on 27.11.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            MugCheckerARView()
                .tabItem {
                    Label("Tasse überprüfen", systemImage: "wand.and.stars")
                }
            
            CoffeeTrackerView()
                .tabItem {
                    Label("Tracker", systemImage: "clock.fill")
                }
            
            CoffeeConsumptionView()
                .tabItem {
                    Label("Kaffeekonsum", systemImage: "mug.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
