//
//  MugARView.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import SwiftUI

struct MugCheckerARView: View {
    @ObservedObject var vm: MugCheckerVM
    
    var body: some View {
        ZStack {
            MugCheckerARViewContainer()
            
            VStack {
                Text("Halte deine Kamera auf eine ebene Fläche.")
                    .foregroundColor(.black)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.white)
                            .shadow(radius: 3)
                    )
                Spacer()
            }
            .padding()
        }
    }
}

struct MugCheckerARView_Previews: PreviewProvider {
    static var previews: some View {
        MugCheckerARView(vm: MugCheckerVM())
    }
}
