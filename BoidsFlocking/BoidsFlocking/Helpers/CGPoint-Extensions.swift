//
//  CGPoint-Extensions.swift
//  BoidsFlocking
//
//  Created by Michael Brünen on 02.04.21.
//

import SwiftUI

extension CGPoint {
    /// Returns the current direction for a point (assuming the point is used to express velocity)
    var heading: Double {
        Double(-atan2(-y, x))
    }

    /// Returns the distance from a given point
    /// - Parameter from: The point to calculate the distance from
    /// - Returns: The distance from the point
    func distance(from: CGPoint) -> CGFloat {
        let distanceSquared = (self.x - from.x) * (self.x - from.x) + (self.y - from.y) * (self.y - from.y)
        return sqrt(distanceSquared)
    }

    /// The length of the of the magnitude
    var magnitude: CGFloat {
        distance(from: .zero)
    }

    /// Limits the value to a given maximum
    /// - Parameter max: The given maximum
    mutating func limit(to max: CGFloat) {
        let length = magnitude

        if length > max {
            x *= max / length
            y *= max / length
        }
    }

    // MARK: - Calculation helpers
    static func *=(lhs: inout CGPoint, rhs: CGFloat) {
        lhs.x *= rhs
        lhs.y *= rhs
    }

    static func /=(lhs: inout CGPoint, rhs: CGFloat) {
        lhs.x /= rhs
        lhs.y /= rhs
    }

    static func +=(lhs: inout CGPoint, rhs: CGPoint) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }

    static func -=(lhs: inout CGPoint, rhs: CGPoint) {
        lhs.x -= rhs.x
        lhs.y -= rhs.y
    }

    static func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }

    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
}
