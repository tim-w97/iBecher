//
//  Card.swift
//  iBecher
//
//  Created by Tim Wagner on 13.01.23.
//

import SwiftUI

/// This is a custom Card view thats encloses another content and adds a custom style
struct Card<Content:View>: View {
    /// The SwiftUI content the Card has to enclose
    @ViewBuilder var content: Content
    
    /// The content just get's stacked with an rounded rectangle with a border and a light shadow
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.cardColor)
                .shadow(radius: 3)
            
            content
        }
    }
}

/// Preview for the custom Card view
struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card {
            Text("Hallo Welt")
        }
    }
}
