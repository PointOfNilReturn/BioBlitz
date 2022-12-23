//
//  BoardViewModel.swift
//  BioBlitz
//
//  Created by Chris Brown on 12/22/22.
//

import SwiftUI

class BoardViewModel: ObservableObject {
    let rowCount = 11
    let columnCount = 22
    
    @Published var grid: [[Bacteria]] = []
    
    @Published var currentPlayer: Color = .green
    @Published var greenScore = 1
    @Published var redScore = 1
    
    @Published var winner: String?
    
    private var bacteriaBeingInfected = 0
    private var infecting: Bool { bacteriaBeingInfected > .zero }
    
    init() {
        reset()
    }
    
    func reset() {
        winner = nil
        currentPlayer = .green
        greenScore = 1
        redScore = 1
        
        grid.removeAll()
        
        for row in 0..<rowCount {
            var bacteriaRow: [Bacteria] = []
            
            for column in 0..<columnCount {
                let bacteria = Bacteria(row: row, column: column)
                
                if row <= rowCount / 2 {
                    if row == 0, column == 0 {
                        bacteria.direction = .north
                    } else if row == 0, column == 1 {
                        bacteria.direction = .east
                    } else if row == 1, column == 0 {
                        bacteria.direction = .south
                    } else {
                        bacteria.direction = Bacteria.Direction.allCases.randomElement()!
                    }
                } else {
                    if let counterpart = getBacteria(row: rowCount - 1 - row, column: columnCount - 1 - column) {
                        bacteria.direction = counterpart.direction.opposite
                    }
                }
                
                bacteriaRow.append(bacteria)
            }
            
            grid.append(bacteriaRow)
        }
        
        grid[0][0].color = .green
        grid[rowCount - 1][columnCount - 1].color = .red
    }
    
    func rotate(bacteria: Bacteria) {
        guard !infecting, bacteria.color == currentPlayer, winner == nil else { return }
        bacteria.direction = bacteria.direction.next
        infect(from: bacteria)
    }
    
}

// MARK: - Private Functions

extension BoardViewModel {
    
    private func changePlayer() {
        if currentPlayer == .green {
            currentPlayer = .red
        } else {
            currentPlayer = .green
        }
    }
    
    private func getBacteria(row: Row, column: Column) -> Bacteria? {
        guard row >= .zero, row < grid.count, column >= .zero, column < grid[0].count else { return nil }
        return grid[row][column]
    }
    
    private func infect(from: Bacteria) {
        var bacteriaToInfect: [Bacteria?] = []
        
        switch from.direction {
            case .north:
                bacteriaToInfect.append(getBacteria(row: from.row - 1, column: from.column))
            case .south:
                bacteriaToInfect.append(getBacteria(row: from.row + 1, column: from.column))
            case .east:
                bacteriaToInfect.append(getBacteria(row: from.row, column: from.column + 1))
            case .west:
                bacteriaToInfect.append(getBacteria(row: from.row, column: from.column - 1))
        }
        
        if let indirect = getBacteria(row: from.row - 1, column: from.column), indirect.direction == .south {
            bacteriaToInfect.append(indirect)
        }
        
        if let indirect = getBacteria(row: from.row + 1, column: from.column), indirect.direction == .north {
            bacteriaToInfect.append(indirect)
        }
        
        if let indirect = getBacteria(row: from.row, column: from.column - 1), indirect.direction == .east {
            bacteriaToInfect.append(indirect)
        }
        
        if let indirect = getBacteria(row: from.row, column: from.column + 1), indirect.direction == .west {
            bacteriaToInfect.append(indirect)
        }
        
        for case let bacteria? in bacteriaToInfect {
            if bacteria.color != from.color {
                bacteria.color = from.color
                bacteriaBeingInfected += 1
                
                Task { @MainActor in
                    try await Task.sleep(for: .milliseconds(50))
                    bacteriaBeingInfected -= 1
                    infect(from: bacteria)
                }
            }
        }
        
        updateScores()
    }
    
    private func updateScores() {
        var newGreenScore = 0
        var newRedScore = 0
        
        for row in grid {
            for bacteria in row {
                if bacteria.color == .green {
                    newGreenScore += 1
                } else if bacteria.color == .red {
                    newRedScore += 1
                }
            }
        }
        
        greenScore = newGreenScore
        redScore = newRedScore
        
        if !infecting {
            withAnimation(.spring()) {
                if redScore == .zero {
                    winner = "Green"
                } else if greenScore == .zero {
                    winner = "Red"
                } else {
                    changePlayer()
                }
            }
        }
    }
    
}
