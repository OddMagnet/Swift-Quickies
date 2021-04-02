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
                    .fill(flock.teamMode ? boid.color : .red)
                    .frame(width: 6, height: 12)
                    .position(x: boid.position.x, y: boid.position.y)
            }
            Circle()    // Obstacle
                .fill(Color.blue)
                .frame(width: 25, height: 25)
                .position(flock.obstacle)


            VStack {
                Spacer()

                HStack {
                    Spacer()
                    VStack {
                        Text("Seperation: \(flock.seperation, specifier: "%.2f")")
                        Slider(value: $flock.seperation, in: 1.0...2.5)
                    }
                    VStack {
                        Text("Align: \(flock.align, specifier: "%.2f")")
                        Slider(value: $flock.align, in: 0.5...2.0)
                    }
                    VStack {
                        Text("Cohere: \(flock.cohere, specifier: "%.2f")")
                        Slider(value: $flock.cohere, in: 0.5...2.0)
                    }
                    Spacer()
                }
                .foregroundColor(.blue)
                .padding(.bottom, 50)
                .background(Color.white)
            }
        }
        .background(Color(white: 0.2, opacity: 1))
        .frame(width: flock.width, height: flock.height)
        .ignoresSafeArea()
        .gesture(
            DragGesture(minimumDistance: 10)
                .onChanged { value in
                    flock.obstacle = value.location
                }
        )
        .onTapGesture {
            flock.teamMode.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
