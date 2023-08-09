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
  
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var selectedCategory: NewsCatagory
    private let newsAPI = NewsAPI.shared
    
    init(articles: [Article]? = nil, selectedCategory: NewsCatagory = .general) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        self.selectedCategory = selectedCategory
    }
    func loadArticles() async {
        phase = .empty
        
        do {
            let articles = try await newsAPI.fetch(from: selectedCategory)
            phase = .success(articles)
        } catch {
            phase = .failure(error)
        }
    }
}
