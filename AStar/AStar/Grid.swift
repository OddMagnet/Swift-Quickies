//
//  Grid.swift
//  AStar
//
//  Created by Michael Brünen on 22.05.21.
//

import SwiftUI
import Combine

class Grid: ObservableObject {
    static let size = 20        // amount of rows and columns

    let squares: [[Square]]     // 2 dimensional array, representing the map
    var startSquare: Square
    var endSquare: Square

    // Variables for scanning neighbors
    var queuedSquares = [Square]()
    var checkedSquares = [Square]()
    var path = [Square]()

    // Variable to help visualise the algorithm
    var stepper: Cancellable?

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
            for square in row {
                if square == startSquare || square == endSquare { continue }
                square.isWall = true
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
        if square == startSquare                {   return .blue                        }
        else if square == endSquare             {   return .green                       }
        else if square.isWall                   {   return .black                       }
        else if path.contains(square)           {   return .white                       }
        else if queuedSquares.contains(square)  {   return .orange                      }
        else if checkedSquares.contains(square) {   return Color.orange.opacity(0.5)    }
        else                                    {   return .gray                        }
    }

    // MARK: - Wall related functions
    /// Resets the walls on the map
    func resetWalls() {
        stepper?.cancel()
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
    /// Wipes the temporary arrays used for finding a route
    func clear() {
        stepper?.cancel()
        objectWillChange.send()

        queuedSquares.removeAll()
        checkedSquares.removeAll()
        path.removeAll()

        for row in squares {
            for square in row {
                square.moveCost = -1
            }
        }
    }

    /// Sets up the route checking and starts stepping through the flood fill algorithm
    func route() {
        // clear existing route data
        clear()

        // add initial square to queue
        queuedSquares.append(startSquare)
        startSquare.moveCost = 0

        // step through the route algorithm until there is nothing left to check
        stepper = DispatchQueue.main.schedule(after: .init(.now()), interval: 0.05, stepRoute)
//        while queuedSquares.isEmpty == false {
//            stepRoute()
//        }
    }

    /// A single step in the process of finding the route, checks the first queues square and calls the flood fill algorithm on it if needed
    func stepRoute() {
        // notify SwiftUI of the upcoming change
        objectWillChange.send()

        // sort the squares based on estimated distance
        queuedSquares.sort { firstSquare, secondSquare in
            let firstHeuristic = estimatedDistance(from: firstSquare, to: endSquare)
            let secondHeuristic = estimatedDistance(from: secondSquare, to: endSquare)
            return firstHeuristic < secondHeuristic
        }
        // check the first square
        let square = queuedSquares.removeFirst()
        checkedSquares.append(square)

        if square == endSquare {    // a route was found
            selectRoute()
            return
        }

        // queue up any possible squares near this one
        floodFill(from: square)

        if queuedSquares.isEmpty {
            // all options were checked
            selectRoute()
        }
    }

    /// Checks all neighbors for a given square and updates the move cost if necessary
    /// - Parameter square: The square for which to check its neighbors
    func floodFill(from square: Square) {
        // get all neighbors
        let checkSquares = neighbors(for: square)

        // check them
        for checkSquare in checkSquares {
            // walls are ignored
            guard checkSquare.isWall == false else { continue }

            // check if it worth moving to the square
            if checkSquare.moveCost == -1 || square.moveCost + 1 < checkSquare.moveCost {
                // update it's move cost
                checkSquare.moveCost = square.moveCost + 1
                // and add it to the list of squares to flood fill from
                queuedSquares.append(checkSquare)
            }
        }
    }

    /// Checks the path array to see if a route was found
    func selectRoute() {
        stepper?.cancel()

        // check if a route was found, if endSquares moveCost is still -1, then there is no route
        guard endSquare.moveCost != -1 else {
            print("No route possible!")
            return
        }

        // go backwards from endSquare
        path.append(endSquare)
        var current = endSquare

        // repeat until startSquare was reached
        while current != startSquare {
            // find all neighbors
            for neighbor in neighbors(for: current) {
                // skip over ignored squares
                guard neighbor.moveCost != -1 else { continue }

                // if this neighbor has a lower move cost than the current move cost, then add this to the path and move there
                if neighbor.moveCost < current.moveCost {
                    path.append(neighbor)
                    current = neighbor

                    // break out of the inner loop, to scan for neighbors from the new current square
                    break
                }
            }
        }
    }

    // MARK: - Distance related functions
    /// Uses the Chebyshev algorithm to estimate the distance between two squares
    /// - Parameters:
    ///   - a: The first square
    ///   - b: The second square
    /// - Returns: The estimated distance between the squares as an Int
    func estimatedDistance(from a: Square, to b: Square) -> Int {
        let xDistance = abs(a.col - b.col)
        let yDistance = abs(a.row - b.row)
        return max(xDistance, yDistance)
    }
}

