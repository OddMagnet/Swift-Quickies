//
//  ContentView.swift
//  BoidsFlocking
//
//  Created by Michael Brünen on 02.04.21.
//

import SwiftUI

struct ContentView: View {
    // Just for preview purposes the flocks size is set to the dimensions of the 12 pro max (@3x)
    @StateObject private var flock = Flock(width: 428, height: 926)

    var body: some View {
        ZStack {
            ForEach(flock.boids) { boid in
                Triangle()
                    .rotation(.radians(boid.velocity.heading + (.pi / 2)))
                    .fill(Color.red)
                    .frame(width: 6, height: 12)
                    .position(x: boid.position.x, y: boid.position.y)
            }

            VStack {
                Spacer()

                HStack {
                    Spacer()
                    VStack {
                        Text("Seperation: \(flock.seperation, specifier: "%.2f")")
                        Slider(value: $flock.seperation, in: 1...2)
                    }
                    VStack {
                        Text("PLACEHOLDER: \(flock.seperation, specifier: "%.2f")")
                        Slider(value: $flock.seperation, in: 1...2)
                    }
                    VStack {
                        Text("PLACEHOLDER: \(flock.seperation, specifier: "%.2f")")
                        Slider(value: $flock.seperation, in: 1...2)
                    }
                    Spacer()
                }
                .padding(.bottom, 20)
                .background(Color.white)
            }
        }
        .background(Color(white: 0.2, opacity: 1))
        .frame(width: flock.width, height: flock.height)
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
