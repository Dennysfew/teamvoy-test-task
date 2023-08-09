//
//  NewsAPI.swift
//  teamvoy-test-task
//
//  Created by Denys on 8/9/23.
//

import Foundation

struct NewsAPI {
    static let shared = NewsAPI()
    
    private init() {}
    
    private let apiKey = "9e4a9c2cbbb44b5b836b0e568608a8cb"
    private let session = URLSession.shared
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func fetch(from category: NewsCategory) async throws -> [Article] {
        try await featchArticles(from: generateNewsURL(from: category))
    }
    
    func search(for query: String) async throws -> [Article] {
        try await featchArticles(from: generateSearchURL(from: query))
    }
    
    private func featchArticles(from url: URL) async throws -> [Article] {
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw generateError(description: "Bad Response")
        }
        
        switch response.statusCode {
        case (200...299), (400...499):
            let apiResponse = try jsonDecoder.decode(NewsAPIResponse.self, from: data)
            if apiResponse.status == "ok" {
                
                return apiResponse.articles ?? []
            } else {
                throw generateError(description: apiResponse.message ?? "An error occured")
            }
        default:
            throw generateError(description: "An server error occured")
        }
    }
    
    private func generateError(code: Int = 1, description: String) -> Error {
        NSError(domain: "NewsAPI", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    private func generateSearchURL(from query: String) -> URL {
        var components = URLComponents(string: "https://newsapi.org/v2/everything")!
        components.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "language", value: "en"),
            URLQueryItem(name: "q", value: query)
        ]
        
        return components.url!
    }
    
    private func generateNewsURL(from category: NewsCategory) -> URL {
        var components = URLComponents(string: "https://newsapi.org/v2/top-headlines")!
        components.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "language", value: "en"),
            URLQueryItem(name: "category", value: category.rawValue)
        ]
        
        return components.url!
    }
}

