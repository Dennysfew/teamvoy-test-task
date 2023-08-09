//
//  EmptyPlaceHolderView.swift
//  teamvoy-test-task
//
//  Created by Denys on 8/9/23.
//

import SwiftUI

struct EmptyPlaceHolderView: View {
    let text: String
    let image: Image?
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            if let image = self.image {
                image
                    .imageScale(.large)
                    .font(.system(size: 52))
            }
            Text(text)
                .font(.headline)
            Spacer()
        }
    }
}
