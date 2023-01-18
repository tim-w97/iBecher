//
//  Card.swift
//  iBecher
//
//  Created by Tim Wagner on 13.01.23.
//

import SwiftUI

struct Card<Content:View>: View {
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.cardColor)
                .shadow(radius: 3)
            
            content
        }
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card {
            Text("Hallo Welt")
        }
    }
}
