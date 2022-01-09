//
//  ContentView.swift
//  WelcomeScreen
//
//  Created by Michael Brünen on 09.01.22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.dismiss) var dismiss

    let features = [
        Feature(title: "Great feature", description: "This one is great, you're going to love using it so much.", image: "pencil.circle"),
        Feature(title: "Second feature", description: "If you liked the first one, wait until you see this.", image: "sun.max"),
        Feature(title: "One last feature", description: "It's tempting to write a lot of text here, but please don't.", image: "keyboard"),
    ]

    var body: some View {
        VStack(spacing: 20) {   // outer spacing affects small print and continue button
            ScrollView {
                VStack(spacing: 20) {   // inner spacing affects welcome and feature text
                    // No Idea why this code does not work
//                    Image(decorative: "AppIcon")
//                        .cornerRadius(10)
                    // The UIKit variant seems to work fine
                    Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                        .cornerRadius(10)
                        .accessibilityHidden(true)

                    (Text("Welcome to ") + Text("OddTracker").foregroundColor(.accentColor))
                        .multilineTextAlignment(.center)
                        .font(.largeTitle.bold())

                    ForEach(features) { feature in
                        HStack {
                            Image(systemName: feature.image)
                                .frame(width: 44)           // SF symbols have slightly varying sizes, ensure they're the same width
                                .font(.title)
                                .foregroundColor(.accentColor)
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
            }

            Text("Any important small print here")
                .font(.footnote)
                .foregroundColor(.secondary)

            Button("Continue") { dismiss() }
                .frame(maxWidth: .infinity, minHeight: 44)  // Apples recommended minimum size for touch controls
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .accentColor(Color(red: 0, green: 0.9, blue: 0, opacity: 1))
            .preferredColorScheme(.light)
    }
}
