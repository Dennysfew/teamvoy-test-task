//
//  NewsAPIResponse.swift
//  teamvoy-test-task
//
//  Created by Denys on 8/8/23.
//

import Foundation

struct NewsAPIResponse: Decodable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String?
}
