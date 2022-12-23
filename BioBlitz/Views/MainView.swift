//
//  MainView.swift
//  BioBlitz
//
//  Created by Chris Brown on 12/22/22.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = BoardViewModel()
    
    var body: some View {
        VStack {
            Header()
            Board()
        }
        .padding()
        .fixedSize()
        .preferredColorScheme(.dark)
        .environmentObject(viewModel)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(BoardViewModel())
    }
}
