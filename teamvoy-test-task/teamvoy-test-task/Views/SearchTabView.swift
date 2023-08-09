//
//  SearchTabView.swift
//  teamvoy-test-task
//
//  Created by Denys on 8/9/23.
//

import SwiftUI

struct SearchTabView: View {
    
    @StateObject private var searchVM = ArticleSearchViewModel()
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(overlayView)
                .navigationTitle("Search")
                .navigationBarItems(trailing: calendar)
        }
        .searchable(text: $searchVM.searchQuery)
        .onSubmit (of: .search, search)
        
    }
    
    private var articles: [Article] {
        if case .success(let articles) = searchVM.dataFetchPhase {
            return articles
        } else {
            return []
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch searchVM.dataFetchPhase {
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
        default:
            EmptyView()
        }
    }
    
    private func search() {
        Task {
            await searchVM.searchArticle()
        }
    }
    
    // MARK: - Calendar
    private var calendar: some View {
        Menu {
            Picker("Date", selection: $searchVM.selectedTimePeriod) {
                ForEach(DateType.allCases) { date in
                    Text(date.text).tag(date)
                }
            }
        } label: {
            Image(systemName: "calendar")
                .imageScale(.large)
        }
    }
}

struct SearchTabView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTabView()
    }
}
