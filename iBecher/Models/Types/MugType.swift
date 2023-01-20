//
//  MugType.swift
//  iBecher
//
//  Created by Tim Wagner on 28.11.22.
//

import Foundation

/// The machines can give you a paper mug with coffee, or you can use a reusable mug.
///
/// This enum descripes if a purchase was with a paperMug or a reusable mug.
enum MugType: Codable {
    case paperMug
    case reusableMug
}
