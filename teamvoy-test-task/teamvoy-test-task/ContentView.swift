//
//  ContentView.swift
//  teamvoy-test-task
//
//  Created by Denys on 8/5/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            newsTab
            searchTab
        }
    }
    
    private var newsTab: some View {
        NewsTabView()
            .tabItem {
                Label("News", systemImage: "newspaper")
            }
    }
    
    private var searchTab: some View {
        SearchTabView()
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
