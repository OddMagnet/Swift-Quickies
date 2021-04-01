//
//  ContentView.swift
//  FloodFill
//
//  Created by Michael Brünen on 01.04.21.
//

import SwiftUI

struct ContentView: View {
    enum DrawingMode {
        case none, drawing, removing
    }

    @ObservedObject var grid = Grid()
    @State private var drawingMode = DrawingMode.none

    let squareSize: CGFloat = 30

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button("Find Route", action: grid.route)
                Button("Clear Route", action: grid.clear)
                Button("Clear Walls", action: grid.resetWalls)
                Button("Randomize", action: grid.randomize)
            }
            .padding()

            VStack(spacing: 0) {
                ForEach(0 ..< Grid.size) { row in
                    HStack(spacing: 0) {
                        ForEach(0 ..< Grid.size) { col in
                            let square = grid.squares[row][col]

                            ZStack {
                                Rectangle()
                                    .fill(grid.color(for: square))

                                if square.isWall == false {
                                    Text(String(square.moveCost))
                                }
                            }
                            .frame(width: squareSize, height: squareSize)
                        }
                    }
                }
            }
            .gesture(
                DragGesture(minimumDistance: 1)
                    .onChanged { value in
                        // get the square for the row and col
                        let row = Int(value.location.y / squareSize)
                        let col = Int(value.location.x / squareSize)
                        let square = grid.squares[row][col]

                        // check drawingMode and take appropriate action
                        switch drawingMode {
                            case .none:
                                if square.isWall { drawingMode = .removing }
                                else { drawingMode = .drawing }
                                fallthrough
                            case .drawing:
                                grid.placeWall(atRow: row, col: col)
                            case .removing:
                                grid.removeWall(atRow: row, col: col)
                        }
                    }
                    .onEnded { _ in
                        drawingMode = .none
                    }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
