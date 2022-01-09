//
//  PageView.swift
//  Tips
//
//  Created by Michael Brünen on 13.02.21.
//

import SwiftUI

struct PageView: View {
    let demoText = String(
        repeating: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
        count: Int.random(in: 2...6)
    )

    var body: some View {
        // Using GeometryReader to add a parallax effect
        GeometryReader { geo in
            ScrollView {
                VStack(alignment: .leading) {
                    Image("Example")
                        .resizable()
                        .scaledToFit()

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Pre-heading here")
                            .font(.subheadline)
                            .textCase(.uppercase)
                            .foregroundColor(.secondary)

                        Text("Heading here")
                            .font(.title)

                        Text(demoText)
                    }
                    .padding([.top, .horizontal])
                    .offset(x: geo.frame(in: .global).minX / 5)
                }
            }
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView()
    }
}
