//
//  ArticleNewsViewModel.swift
//  teamvoy-test-task
//
//  Created by Denys on 8/9/23.
//

import SwiftUI

enum DataFetchPhase<T> {
    
    case empty
    case success(T)
    case failure(Error)
}

@MainActor
class ArticleNewsViewModel: ObservableObject {
  
    @Published var dataFetchPhase = DataFetchPhase<[Article]>.empty
    @Published var selectedCategory: NewsCategory
    private let newsAPI = NewsAPI.shared
    
    init(articles: [Article]? = nil, selectedCategory: NewsCategory = .general) {
        if let articles = articles {
            self.dataFetchPhase = .success(articles)
        } else {
            self.dataFetchPhase = .empty
        }
        self.selectedCategory = selectedCategory
    }
    
    func loadArticles() async {
        dataFetchPhase = .empty
        
        do {
            let articles = try await newsAPI.fetch(from: selectedCategory)
            dataFetchPhase = .success(articles)
        } catch {
            dataFetchPhase = .failure(error)
        }
    }
}
