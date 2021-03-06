//
//  Boid.swift
//  BoidsFlocking
//
//  Created by Michael Brünen on 02.04.21.
//

import SwiftUI

class Boid: Identifiable {
    let id = UUID()
    let color: Color = [.green, .white, .orange, .pink, .yellow].randomElement()!   // Team color

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
        var acceleration = separate(from: flock) * flock.seperation
        acceleration += align(to: flock) * flock.align
        acceleration += cohere(to: flock) * flock.cohere
        acceleration += avoid(flock.obstacle) * 10
        return acceleration
    }

    /// Calculates the adjustment needed to separate
    /// - Parameter flock: The flock to calculate for
    /// - Returns: The adjustment needed to separate as a CGPoint
    private func separate(from flock: Flock) -> CGPoint {
        // find all neighbors up to 30^2 points away from the current boid
        let nearby = neighbors(in: flock, distanceCutOff: 900)

        // no neighbors? no adjustment
        guard nearby.count > 0 else { return .zero }

        // calculate (sum up) the adjustment, taking into account distance difference
        var acceleration = nearby.reduce(CGPoint.zero) {
            var difference = position - $1.boid.position        // get distance between the boids
            difference /= $1.distance                           // divide by the distance, so further boids have less impact
            return $0 + difference                              // add to the sum
        }

        // get mean average
        acceleration /= CGFloat(nearby.count)

        // return the steering adjusted acceleration
        return steer(acceleration)
    }

    /// Calculates the boids alignment
    /// - Parameter flock: The flock to calculate for
    /// - Returns: The adjustment needed to align as a CGPoint
    private func align(to flock: Flock) -> CGPoint {
        // find all neighbors up to 50^2 points away from the current boid
        let nearby = neighbors(in: flock, distanceCutOff: 2500)
        // no neighbors? no adjustment
        guard nearby.count > 0 else { return .zero }

        // calculate the total velocity
        var acceleration = nearby.reduce(CGPoint.zero) {
            $0 + $1.boid.velocity
        }

        // get mean average
        acceleration /= CGFloat(nearby.count)

        // return the steering adjusted velocity
        return steer(acceleration)
    }

    /// Calculates the boids coherence
    /// - Parameter flock: The flock to calculate for
    /// - Returns: The adjustment needed to cohere as a CGPoint
    private func cohere(to flock: Flock) -> CGPoint {
        // find all neighbors up to 50^2 points away from the current boid
        let nearby = neighbors(in: flock, distanceCutOff: 2500)
        // no neighbors? no adjustment
        guard nearby.count > 0 else { return .zero }

        // calculate total position
        var acceleration = nearby.reduce(CGPoint.zero) {
            $0 + $1.boid.position
        }

        // get mean average and subtract own position
        acceleration /= CGFloat(nearby.count)
        acceleration -= position

        // return the steering adjusted coherence
        return steer(acceleration)
    }

    private func avoid(_ obstacle: CGPoint) -> CGPoint {
        let distance = position.distanceSquared(from: obstacle)
        let distanceCutOff: CGFloat = 750

        guard distance < distanceCutOff else { return .zero }

        var acceleration = position - obstacle
        acceleration /= distance

        return steer(acceleration)
    }

    // MARK: - Helper functions
    /// Get all neighbors with their distance to the current boid
    /// - Parameters:
    ///   - flock: The flock to search in
    ///   - distanceCutOff: The maximal search distance
    /// - Returns: The current boids neighbors and their distance from the current boid
    private func neighbors(in flock: Flock, distanceCutOff: CGFloat) -> [(boid: Boid, distance: CGFloat)] {
        flock.boids.compactMap { otherBoid in       // compactMap to sort out the nil values
            // if team mode is enabled, sort out all boids of other teams as well
            if flock.teamMode == true && self.color != otherBoid.color { return nil }

            let distance = position.distanceSquared(from: otherBoid.position)

            if distance > 0 && distance < distanceCutOff {
                return (otherBoid, distance)
            } else {
                return nil
            }
        }
    }

    /// Returns a steering adjustment based on an acceleration
    /// - Parameter acceleration: The acceleration as a CGPoint
    /// - Returns: The calculated steering adjustment
    private func steer(_ acceleration: CGPoint) -> CGPoint {
        var acceleration = acceleration

        acceleration.normalize()            // normalize the acceleration
        acceleration *= maximumSpeed        // multiply by maximumSpeed, so the length increases
        acceleration -= velocity            // subtract current velocity for gradual change

        let maximumSteer: CGFloat = 0.04    // and limit the steer of the acceleration
        acceleration.limit(to: maximumSteer)

        return acceleration
    }
}
