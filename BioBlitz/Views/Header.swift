//
//  Header.swift
//  BioBlitz
//
//  Created by Chris Brown on 12/22/22.
//

import SwiftUI

struct Header: View {
    @EnvironmentObject var viewModel: BoardViewModel
    
    var body: some View {
        ZStack {
            HStack {
                Text("GREEN: \(viewModel.greenScore)")
                    .padding(.horizontal)
                    .background(Capsule().fill(.green).opacity(viewModel.currentPlayer == .green ? 1 : 0))
                
                Spacer()
                
                Text("RED: \(viewModel.redScore)")
                    .padding(.horizontal)
                    .background(Capsule().fill(.red).opacity(viewModel.currentPlayer == .red ? 1 : 0))
            }            
            Text("BIOBLITZ")
        }
        .font(.system(size: 36, weight: .black))
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
            .environmentObject(BoardViewModel())
    }
}
