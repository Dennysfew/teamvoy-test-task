//
//  ArticleListView.swift
//  teamvoy-test-task
//
//  Created by Denys on 8/8/23.
//

import SwiftUI

struct ArticleListView: View {
    
    let articles: [Article]
    @State private var selectedArticle: Article?
    
    
    var body: some View {
        List {
            ForEach(articles) { article in
                ArticleRowView(article: article)
                    .onTapGesture {
                        selectedArticle = article
                    }
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .sheet(item: $selectedArticle) {
            SafaryView(url: $0.articleURL)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ArticleListView(articles: Article.defaultData)
        }
       
    }
}
