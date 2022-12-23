//
//  Bacteria.swift
//  BioBlitz
//
//  Created by Chris Brown on 12/22/22.
//

import SwiftUI

typealias Row = Int
typealias Column = Int
typealias Degree = Double

class Bacteria {
    var row: Row
    var column: Column
    
    var color: Color = .gray
    var direction: Direction = .north
    
    init(row: Row, column: Column) {
        self.row = row
        self.column = column
    }
}

// MARK: - Direction

extension Bacteria {
    
    enum Direction: CaseIterable {
        case north, south, east, west
        
        var degrees: Degree {
            switch self {
                case .north:
                    return .zero
                case .south:
                    return 180
                case .east:
                    return 90
                case .west:
                    return 270
            }
        }
        
        var next: Direction {
            switch self {
                case .north:
                    return .east
                case .south:
                    return .west
                case .east:
                    return .south
                case .west:
                    return .north
            }
        }
        
        var opposite: Direction {
            switch self {
                case .north:
                    return .south
                case .south:
                    return .north
                case .east:
                    return .west
                case .west:
                    return .east
            }
        }
    }
    
}
