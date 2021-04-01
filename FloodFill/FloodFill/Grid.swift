//
//  Grid.swift
//  FloodFill
//
//  Created by Michael Brünen on 01.04.21.
//

import SwiftUI

class Grid: ObservableObject {
    static let size = 20        // amount of rows and columns

    let squares: [[Square]]     // 2 dimensional array, representing the map
    var startSquare: Square
    var endSquare: Square

    init() {
        var grid = [[Square]]()

        for row in 0..<Grid.size {                          // for every row
            var rows = [Square]()                           // create a temporary array to hold the row that is about to be created

            for col in 0..<Grid.size {                      // for every column
                let square = Square(row: row, col: col)     // create a square for the current column
                rows.append(square)                         // and add it to the temporary row array
            }

            grid.append(rows)                               // finally, append the row to the grid, then repeat
        }

        squares = grid
        startSquare = grid[1][1]
        endSquare = grid[Grid.size - 2][Grid.size - 2]

    }

    // MARK: - Helper functions
    /// Generates a random amount of walls on the map
    func randomize() {
        objectWillChange.send()

        // First set all squares other than start and end to walls
        for row in squares {
            for col in row {
                if col == startSquare || col == endSquare { continue }
                col.isWall = true
            }
        }

        // Then set a random amount back to no wall (ideally 250 squares, but that is only the case when there are no duplicates)
        for _ in 1...250 {
            let randomRow = Int.random(in: 0..<Grid.size)
            let randomCol = Int.random(in: 0..<Grid.size)
            squares[randomRow][randomCol].isWall = false
        }

        route()
    }

    /// Returns all neighbors of a square
    /// - Parameter square: The square to check
    /// - Returns: An array of squares surrounding the checked square
    func neighbors(for square: Square) -> [Square] {
        var neighbors = [Square]()

        // check squares to the left, append them if they exist
        if (square.col > 0) {
            neighbors.append(squares[square.row][square.col - 1])           // direct left
            if (square.row > 0) {
                neighbors.append(squares[square.row - 1][square.col - 1])   // upper left
            }
            if (square.row < Grid.size - 1) {
                neighbors.append(squares[square.row + 1][square.col - 1])   // lower left
            }
        }

        // check squares to the right, append them if they exist
        if (square.col < Grid.size - 1) {
            neighbors.append(squares[square.row][square.col + 1])           // direct right
            if (square.row > 0) {
                neighbors.append(squares[square.row - 1][square.col + 1])   // upper right
            }
            if (square.row < Grid.size - 1) {
                neighbors.append(squares[square.row + 1][square.col + 1])   // lower right
            }
        }

        // finally, check the squares above and below
        if (square.row > 0) {
            neighbors.append(squares[square.row - 1][square.col])
        }
        if (square.row < Grid.size - 1) {
            neighbors.append(squares[square.row + 1][square.col])
        }

        // return all surrounding squares
        return neighbors
    }

    /// Returns a color based on the square type
    /// - Parameter square: The square to get a color for
    /// - Returns: The fitting color for the square
    func color(for square: Square) -> Color {
        if square == startSquare {      return .blue }
        else if square == endSquare {   return .green }
        else if square.isWall {         return .black }
        else {                          return .gray }
    }

    // MARK: - Wall related functions
    /// Resets the walls on the map
    func resetWalls() {
        objectWillChange.send()

        for row in squares {
            for col in row {
                col.isWall = false
            }
        }
    }

    /// Places a wall
    /// - Parameters:
    ///   - row: The row to place the wall
    ///   - col: The column to place the wall
    func placeWall(atRow row: Int, col: Int) {
        guard squares[row][col].isWall == false else { return }

        objectWillChange.send()
        squares[row][col].isWall = true
    }

    /// Removes a wall
    /// - Parameters:
    ///   - row: The row to remove the wall
    ///   - col: The column to remove the wall
    func removeWall(atRow row: Int, col: Int) {
        guard squares[row][col].isWall == true else { return }

        objectWillChange.send()
        squares[row][col].isWall = false
    }


    // MARK: - Route related functions
    func clear() {
        // TODO: - add code
    }

    func route() {
        // TODO: - add code
    }
}
