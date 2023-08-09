//
//  ArticleSearchViewModel.swift
//  teamvoy-test-task
//
//  Created by Denys on 8/9/23.
//

import SwiftUI

@MainActor
class ArticleSearchViewModel: ObservableObject {
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var searchQuery = ""
    private let newsAPI = NewsAPI.shared
    
    func searchArticle() async {
        let searchQuery = self.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        phase = .empty
        
        if searchQuery.isEmpty {
            return
        }
        
        do {
            let articles = try await newsAPI.search(for: searchQuery)
            phase = .success(articles)
            
        } catch {
            phase = .failure(error)
        }
    }
}
