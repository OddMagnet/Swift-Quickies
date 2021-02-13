//
//  ListingView.swift
//  Tips
//
//  Created by Michael Brünen on 13.02.21.
//

import SwiftUI

struct ListingView: View {
    var body: some View {
        /*
         To get the large image that is at the top in Apple's Tips a few things are needed
         - To get rid of the separator of the normal rows, a section header is used for it
         - To have the image scroll with the rest of the content, `GroupedListStyle` is used
         - To fix the different cell colouring a special background color is used
         */
        List {
            Section(header: Text("Header")) {
                ForEach(0 ..< 30) { row in
                    NavigationLink(destination: Text("Detail View")) {
                        ListingRow()
                    }
                    .listRowBackground(Color("Background"))
                }
            }
        }
        .listStyle(GroupedListStyle())
    }
}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListingView()
    }
}
