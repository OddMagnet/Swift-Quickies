//
//  DetailView.swift
//  Tips
//
//  Created by Michael Brünen on 13.02.21.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        TabView {
            ForEach(0 ..< 5) { _ in
                PageView()
            }
        }
        .navigationTitle("Essentials")
        .navigationBarTitleDisplayMode(.inline)
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView()
        }
    }
}
