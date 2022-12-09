//
//  MugButton.swift
//  iBecher
//
//  Created by Tim Wagner on 09.12.22.
//

import SwiftUI

struct MugButton: View {
    let coffeeSize: CoffeeSize
    @Binding var selectedCoffeeSize: CoffeeSize
    let action: ()->()
    
    var body: some View {
        Button(action: action) {
            VStack {
                ZStack {
                    Image(systemName: "mug.fill")
                        .font(coffeeSize == .small ? .title : .system(size: 50))
                        .foregroundColor(coffeeSize == selectedCoffeeSize ? .blue : .gray)
                    
                    Circle()
                        .stroke(coffeeSize == selectedCoffeeSize ? .blue : .gray, lineWidth: 8)
                }.frame(width: 100, height: 100)
                
                Text(coffeeSize == .small ? "Klein" : "Groß")
            }
        }
    }
}

struct MugButton_Previews: PreviewProvider {
    static var previews: some View {
        MugButton(
            coffeeSize: .small,
            selectedCoffeeSize: .constant(.small),
            action: {}
        )
    }
}
