//
//  MugButton.swift
//  iBecher
//
//  Created by Tim Wagner on 09.12.22.
//

import SwiftUI

/// The Mug Button is one of two buttons to chose the desired coffee size
struct MugButton: View {
    let coffeeSize: CoffeeSize
    
    @Binding var selectedCoffeeSize: CoffeeSize
    @Binding var mugType: MugType
    
    /// The action of the Mug Button gets passed from the parent view
    let action: ()->()
    
    /// Returns the corresponding image to the selected mug type and coffee size
    /// - Returns: Asset name of the image to use
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
    
    /// The Mug Button consists of a circle, stacked with the corresponding image, and a small description at the bottom
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

/// Preview for the Mug Button
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
