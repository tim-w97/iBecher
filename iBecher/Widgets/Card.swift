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
                .fill(.white)
                .shadow(radius: 5)
            
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
