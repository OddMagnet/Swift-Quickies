//
//  ContentView.swift
//  Lockscreen
//
//  Created by Michael Brünen on 07.02.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            GeometryReader { geo in
                // MARK: - Background
                Image("bigsur")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: geo.size.width)

                Color.black.opacity(0.15)

                // MARK: - Content
                VStack(spacing: 0) {
                    Image(systemName: "lock.fill")
                        .font(.largeTitle)
                        .padding(.top, 60)

                    // using the new `style` parameter from iOS 14
                    Text(Date(), style: .time)
                        .font(.system(size: 92, weight: .thin))

                    Text(Date(), style: .date)
                        .font(.title2)

                    Spacer()

                    HStack {
                        Spacer()
                    }

                    Capsule()
                        .fill(Color.white)
                        .frame(width: 150, height: 5)
                        .padding(.bottom, 10)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.locale, .init(identifier: "de"))
    }
}
