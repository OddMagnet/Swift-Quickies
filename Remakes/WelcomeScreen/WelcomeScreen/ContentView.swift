//
//  ContentView.swift
//  WelcomeScreen
//
//  Created by Michael Brünen on 09.01.22.
//

import SwiftUI

struct ContentView: View {
    let features = [
        Feature(title: "Great feature", description: "This one is great, you're going to love using it so much.", image: "pencil.circle"),
        Feature(title: "Second feature", description: "If you liked the first one, wait until you see this.", image: "sun.max"),
        Feature(title: "One last feature", description: "It's tempting to write a lot of text here, but please don't.", image: "keyboard"),
    ]

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to OddTracker")
                .multilineTextAlignment(.center)
                .font(.largeTitle.bold())

            ForEach(features) { feature in
                HStack {
                    Image(systemName: feature.image)
                        .frame(width: 44)           // SF symbols have slightly varying sizes, ensure they're the same width
                        .font(.title)
                        .foregroundColor(.blue)
                        .accessibilityHidden(true)  // hide from screen readers, since they're decorative

                    VStack(alignment: .leading) {
                        Text(feature.title)
                            .font(.headline)

                        Text(feature.description)
                            .foregroundColor(.secondary)
                    }
                    .accessibilityElement(children: .combine)   // should be read together by screen readers
                }
                .frame(maxWidth: .infinity, alignment: .leading)// ensure text is perfectly aligned, even when shorter
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
