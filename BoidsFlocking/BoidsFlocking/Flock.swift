//
//  Flock.swift
//  BoidsFlocking
//
//  Created by Michael Brünen on 02.04.21.
//

import SwiftUI

class Flock: ObservableObject {
    let width: CGFloat
    let height: CGFloat

    var boids = [Boid]()

    init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height

        // create some boids
        for _ in 1...200 {
            let newBoid = Boid(x: CGFloat.random(in: 0 ..< width), y: CGFloat.random(in: 0 ..< height))
            boids.append(newBoid)
        }
    }
}
