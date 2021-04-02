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
    var teamMode = false
    var obstacle: CGPoint

    // Specialized timer to synchronize frame redraws
    var displayLink: CADisplayLink?

    // Behaviour settings
    @Published var seperation: CGFloat = 1.5
    @Published var align: CGFloat = 1.0
    @Published var cohere: CGFloat = 1.0

    init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
        obstacle = CGPoint(x: width / 2, y: height / 2)

        // create some boids
        for _ in 1...200 {
            let newBoid = Boid(x: CGFloat.random(in: 0 ..< width), y: CGFloat.random(in: 0 ..< height))
            boids.append(newBoid)
        }

        // setup the timer
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink?.add(to: .current, forMode: .default)
    }

    // Update function that the timer calls
    @objc func update() {
        objectWillChange.send()
        
        for boid in boids {
            boid.run(in: self)
        }
    }
}
