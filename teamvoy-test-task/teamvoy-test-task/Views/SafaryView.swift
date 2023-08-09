//
//  SafaryView.swift
//  teamvoy-test-task
//
//  Created by Denys on 8/8/23.
//

import SwiftUI
import SafariServices

struct SafaryView: UIViewControllerRepresentable {
    let url : URL
    
    func makeUIViewController(context: Context) -> some SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
