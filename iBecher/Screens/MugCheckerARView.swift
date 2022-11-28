//
//  MugARView.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import SwiftUI

struct MugCheckerARView: View {
    var body: some View {
        VStack {
            Text("Stelle deine Tasse auf eine ebene Fläche und drücke auf Start.")
                .multilineTextAlignment(.center)
            
            Button("Start", action: {})
                .padding()
                .buttonStyle(.bordered)
        }
    }
}

struct MugCheckerARView_Previews: PreviewProvider {
    static var previews: some View {
        MugCheckerARView()
    }
}
