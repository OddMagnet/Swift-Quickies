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

    // Specialized timer to synchronize frame redraws
    var displayLink: CADisplayLink?

    init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height

        // create some boids
        for _ in 1...200 {
            let newBoid = Boid(x: CGFloat.random(in: 0 ..< width), y: CGFloat.random(in: 0 ..< height))
            boids.append(newBoid)

            // setup the timer
            displayLink = CADisplayLink(target: self, selector: #selector(update))
            displayLink?.add(to: .current, forMode: .default)
        }
    }

    // Update function that the timer calls
    @objc func update() {
        objectWillChange.send()
        // TODO: Add updating code
    }
}
