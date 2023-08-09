//
//  NewsTabView.swift
//  teamvoy-test-task
//
//  Created by Denys on 8/9/23.
//

import SwiftUI

struct NewsTabView: View {
    
    @StateObject var articleNewsVM = ArticleNewsViewModel()
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(overlayView)
                .refreshable {
                    loadArticles()
                }
                .onAppear {
                    loadArticles()
                    
                }
                .onChange(of: articleNewsVM.selectedCategory) { _ in
                    loadArticles()
                }
                .navigationTitle(articleNewsVM.selectedCategory.text)
                .navigationBarItems(trailing: menu)
        }
    }
    // MARK: - Private Views
    
    @ViewBuilder
    private var overlayView: some View {
        switch articleNewsVM.dataFetchPhase {
        case .empty:
            ProgressView()
        case .success(let articles) where articles.isEmpty:
            EmptyPlaceHolderView(text: "No Articles", image: nil)
        case .failure(let error):
            RetryView(text: error.localizedDescription) {
                loadArticles()
            }
        default:
            EmptyView()
        }
    }
    
    private var articles: [Article] {
        if case let .success(articles) = articleNewsVM.dataFetchPhase {
            return articles
        } else {
            return []
        }
    }
    // MARK: - Private Methods
    private func loadArticles() {
        Task {
            await articleNewsVM.loadArticles()
        }
    }
    // MARK: - Menu
    private var menu: some View {
        Menu {
            Picker("Categoty", selection: $articleNewsVM.selectedCategory) {
                ForEach(NewsCategory.allCases) { categoty in
                    Text(categoty.text).tag(categoty)
                }
            }
        } label: {
            Image(systemName: "fiberchannel")
                .imageScale(.large)
        }
    }
    
}

struct NewsTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewsTabView(articleNewsVM: ArticleNewsViewModel(articles: Article.defaultData))
    }
}
