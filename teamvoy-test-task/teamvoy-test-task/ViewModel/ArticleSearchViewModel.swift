//
//  ArticleSearchViewModel.swift
//  teamvoy-test-task
//
//  Created by Denys on 8/9/23.
//

import SwiftUI

@MainActor
class ArticleSearchViewModel: ObservableObject {
    @Published var dataFetchPhase = DataFetchPhase<[Article]>.empty
    @Published var selectedTimePeriod: DateType = .lastMonth
    @Published var searchQuery = ""
    private let newsAPI = NewsAPI.shared
    
    func searchArticle() async {
        let trimmedQuery = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedQuery.isEmpty else {
            dataFetchPhase = .empty
            return
        }
        
        do {
            let articles = try await newsAPI.search(for: trimmedQuery, during: selectedTimePeriod)
            dataFetchPhase = .success(articles)
        } catch {
            dataFetchPhase = .failure(error)
        }
    }
}
