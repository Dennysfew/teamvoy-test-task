//
//  ArticleRowView.swift
//  teamvoy-test-task
//
//  Created by Denys on 8/8/23.
//

import SwiftUI

struct ArticleRowView: View {
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            ArticleImageView(article: article)
            
            ArticleContentView(article: article)
        }
    }
}
// MARK: - ArticleImageView

struct ArticleImageView: View {
    let article: Article
    
    var body: some View {
        AsyncImage(url: article.imageURL) {
            phase in
            switch phase {
            case .empty:
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case .failure:
                
                HStack {
                    Spacer()
                    Image(systemName: "photo")
                        .imageScale(.large)
                    Spacer()
                }
                
            @unknown default:
                fatalError()
            }
        }
        .frame(minHeight: 200, maxHeight: 250)
        .background(Color.gray.opacity(0.3))
        .clipped()
    }
}

// MARK: - ArticleContentView

struct ArticleContentView: View {
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(article.title)
                .font(.headline)
                .lineLimit(3)
            Text(article.descriptionText)
                .font(.subheadline)
                .lineLimit(2)
            
            HStack {
                Text(article.captionText)
                    .lineLimit(1)
                    .foregroundColor(.secondary)
                    .font(.caption)
                Spacer()
                
                ShareButton(url: article.articleURL)
            }
        }
        .padding([.horizontal, .bottom])
    }
}

// MARK: - ShareButton

struct ShareButton: View {
    let url: URL
    
    var body: some View {
        Button {
            presentShareSheet(url: url)
        } label: {
            Image(systemName: "square.and.arrow.up")
        }
        .buttonStyle(.bordered)
    }
}

extension View {
    func presentShareSheet(url: URL)  {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController?
            .present(activityVC, animated: true)
        
    }
}

struct ArticleRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List  {
                ArticleRowView(article: .defaultData[0])
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.plain)
            
        }
    }
}
