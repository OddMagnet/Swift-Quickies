//
//  Square.swift
//  AStar
//
//  Created by Michael Brünen on 22.05.21.
//

import SwiftUI

/// Represents a single square on the map
class Square: Equatable {
    var row: Int            // the squares row
    var col: Int            // and column
    var isWall = false      // if the square is a wall
    var moveCost = -1       // cost to moving to this square, gets set by grid later

    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }

    static func ==(lhs: Square, rhs: Square) -> Bool {
        lhs.row == rhs.row && lhs.col == rhs.col
    }
}

