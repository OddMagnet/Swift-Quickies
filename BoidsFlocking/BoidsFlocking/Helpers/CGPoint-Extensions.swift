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
}
