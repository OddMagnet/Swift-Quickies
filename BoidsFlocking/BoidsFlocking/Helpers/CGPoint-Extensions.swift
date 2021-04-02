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
