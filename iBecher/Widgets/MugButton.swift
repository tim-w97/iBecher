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
    @Binding var mugType: MugType
    
    let action: ()->()
    
    private func getMugImage() -> String {
        if mugType == .paperMug {
            if coffeeSize == .small {
                return "small paper mug"
            } else {
                return "big paper mug"
            }
        } else {
            if coffeeSize == .small {
                return "small mug"
            } else {
                return "big mug"
            }
        }
    }
    
    var body: some View {
        Button(action: action) {
            VStack {
                ZStack {
                    Image(getMugImage()).resizable()
                    
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
            mugType: .constant(.paperMug),
            action: {}
        )
    }
}
