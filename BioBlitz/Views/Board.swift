//
//  Board.swift
//  BioBlitz
//
//  Created by Chris Brown on 12/22/22.
//

import SwiftUI

struct Board: View {
    @EnvironmentObject var viewModel: BoardViewModel
    
    var body: some View {
        ZStack {
            Grid {
                ForEach(0..<viewModel.rowCount, id: \.self) { row in
                    GridRow {
                        ForEach(0..<viewModel.columnCount, id: \.self) { column in
                            let bacteria = viewModel.grid[row][column]
                            BacteriaView(bacteria: bacteria) {
                                viewModel.rotate(bacteria: bacteria)
                            }
                        }
                    }
                }
            }
            
            if let winner = viewModel.winner {
                VStack {
                    Text("\(winner) wins!")
                        .font(.largeTitle)
                    
                    Button(action: viewModel.reset) {
                        Text("Play Again")
                            .padding()
                            .background(.blue)
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                }
                .padding(40)
                .background(.black.opacity(0.85))
                .cornerRadius(25)
                .transition(.scale)
            }
        }
    }
}

struct Board_Previews: PreviewProvider {
    static var previews: some View {
        Board()
            .environmentObject(BoardViewModel())
    }
}
