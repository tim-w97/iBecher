//
//  TimeInterval.swift
//  iBecher
//
//  Created by Tim Wagner on 16.01.23.
//

import Foundation

/// The time period for a summary of multiple coffee purchases can be weekly, monthly, yearly or total (summary of all coffee purchases)
enum TimePeriod {
    case weekly
    case monthly
    case yearly
    case total
}
