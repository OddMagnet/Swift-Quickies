//
//  Square.swift
//  FloodFill
//
//  Created by Michael Brünen on 01.04.21.
//

import SwiftUI

/// Represents a single square on the map
class Square: Equatable {
    var row: Int            // the squares row
    var col: Int            // and column
    var isWall = false
    var moveCost = -1

    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }

    static func ==(lhs: Square, rhs: Square) -> Bool {
        lhs.row == rhs.col && lhs.col == rhs.col
    }
}
