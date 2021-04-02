//
//  Boid.swift
//  BoidsFlocking
//
//  Created by Michael Brünen on 02.04.21.
//

import SwiftUI

class Boid: Identifiable {
    let id = UUID()

    var position: CGPoint           // current position
    var velocity: CGPoint           // current velocity, stored as CGPoint instead of CGVector to avoid constant conversion
    let maximumSpeed: CGFloat = 2   // the maximum speed the boid can travel at

    init(x: CGFloat, y: CGFloat) {
        position = CGPoint(x: x, y: y)

        let angle = Double.random(in: 0...(.pi * 2))
        velocity = CGPoint(x: cos(angle), y: sin(angle))
    }

    /// Calculates the new position of the boid
    /// - Parameter flock: The flock the boid is in
    func run(in flock: Flock) {
        velocity += calculateAcceleration(with: flock)
        velocity.limit(to: maximumSpeed)
        position += velocity

        // check if boid is offscreen
        wrap(in: flock)
    }

    private func wrap(in flock: Flock) {
        let boidSize: CGFloat = 5

        if position.x < -boidSize {                     // is the boid offscreen to the left?
            position.x = flock.width + boidSize         // then move it to the right
        } else if position.x > flock.width + boidSize { // is the boid offscreen to the right?
            position.x = -boidSize                      // then move it to the left
        }

        if position.y < -boidSize {                     // is the boid offscreen to the top?
            position.y = flock.height + boidSize        // then move it to the bottom
        } else if position.y > flock.height + boidSize {// is the boid offscreen to the bottom?
            position.y = -boidSize                      // then move it to the top
        }
    }

    // MARK: - Flocking behaviours
    private func calculateAcceleration(with flock: Flock) -> CGPoint {
        .zero
    }

    private func separate(from flock: Flock) -> CGPoint {
        .zero
    }

    private func align(to flock: Flock) -> CGPoint {
        .zero
    }

    private func cohere(to flock: Flock) -> CGPoint {
        .zero
    }
}
