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

    func run(in flock: Flock) {
        velocity += calculateAcceleration(with: flock)
        velocity.limit(to: maximumSpeed)
        position += velocity
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
