//
//  NewsCatagory.swift
//  teamvoy-test-task
//
//  Created by Denys on 8/9/23.
//

import SwiftUI

enum NewsCatagory: String, CaseIterable {
    case general
    case business
    case technology
    case entertainment
    case sports
    case sience
    case health
    
    var text: String {
        if self == .general {
            return "Top Headlines"
        }
        return rawValue.capitalized
    }
 
}

extension NewsCatagory: Identifiable {
    var id: Self { self }
}
