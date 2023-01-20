//
//  Color+CustomColors.swift
//  iBecher
//
//  Created by Tim Wagner on 18.01.23.
//

import Foundation
import SwiftUI

extension Color {
    /// Custom Color for the card view, changes wether the user is in light mode or dark mode
    public static let cardColor = Color(UIColor(named: "CardColor") ?? .white)
}
