//
//  ContentView.swift
//  Tips
//
//  Created by Michael Brünen on 13.02.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ListingView()
                .navigationTitle("Collections")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
