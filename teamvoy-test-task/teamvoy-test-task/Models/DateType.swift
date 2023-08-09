//
//  DateType.swift
//  teamvoy-test-task
//
//  Created by Denys on 8/10/23.
//

import SwiftUI

enum DateType: String, CaseIterable {
    case today
    case yesterday
    case lastThreeDays
    case lastWeek
    case lastTwoWeeks
    case lastMonth
    
    var text: String {
        switch self {
        case .today:
            return "Today"
        case .yesterday:
            return "Yesterday"
        case .lastThreeDays:
            return "Last 3 Days"
        case .lastWeek:
            return "Last Week"
        case .lastTwoWeeks:
            return "Last 2 Weeks"
        case .lastMonth:
            return "Last Month"
            
        }
    }
}

extension DateType: Identifiable {
    var id: Self { self }
}
