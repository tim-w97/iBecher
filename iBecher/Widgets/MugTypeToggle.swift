//
//  MugTypeSwitch.swift
//  iBecher
//
//  Created by Tim Wagner on 09.12.22.
//

import SwiftUI

struct MugTypeToggle: View {
    @Binding var isOn: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20).stroke(isOn ? .green : .gray, lineWidth: 8)
            
            Toggle(isOn ? "Ja! 😍" : "Nein. 😔", isOn: $isOn)
                .padding()
        }.frame(width: 170, height: 100)
    }
}

struct MugTypeSwitch_Previews: PreviewProvider {
    static var previews: some View {
        MugTypeToggle(isOn: .constant(true))
    }
}
