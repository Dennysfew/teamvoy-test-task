//
//  SearchTabView.swift
//  teamvoy-test-task
//
//  Created by Denys on 8/9/23.
//

import SwiftUI

struct SearchTabView: View {
    
    @StateObject var searchVM = ArticleSearchViewModel()
    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(overlayView)
                .navigationTitle("Search")
        }
        .searchable(text: $searchVM.searchQuery)
        .onSubmit (of: .search, search)
        
    }
    
    
    private var articles: [Article] {
        if case .success(let articles) = searchVM.phase {
            return articles
        } else {
            return []
        }
    }
    @ViewBuilder
    private var overlayView: some View {
        switch searchVM.phase {
        case .empty:
            if !searchVM.searchQuery.isEmpty {
                ProgressView()
            } else {
                EmptyPlaceHolderView(text: "Type your query to search", image: Image(systemName: "magnifyingglass"))
            }
        case .success(let articles) where articles.isEmpty:
            EmptyPlaceHolderView(text: "No search results found", image: Image(systemName: "magnifyingglass"))
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: search)
        default: EmptyView()
        }
    }
    
    private func search() {
        Task {
            await searchVM.searchArticle()
        }
    }
}

struct SearchTabView_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchTabView()
    }
}
