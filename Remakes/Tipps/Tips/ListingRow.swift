//
//  ListingRow.swift
//  Tips
//
//  Created by Michael Brünen on 13.02.21.
//

import SwiftUI

struct ListingRow: View {
    var body: some View {
        HStack(spacing: 10) {
            Image("iPhone")
                .background(Color(white: 0.7).opacity(0.25))
                .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading) {
                Text("Welcome to iPhone")
                    .font(.title3)
                    .bold()

                Text("Get to know your iPhone")
                
                Text("5 Tips")
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct ListingRow_Previews: PreviewProvider {
    static var previews: some View {
        ListingRow()
    }
}
