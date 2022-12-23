//
//  BacteriaView.swift
//  BioBlitz
//
//  Created by Chris Brown on 12/22/22.
//

import SwiftUI

struct BacteriaView: View {
    let bacteria: Bacteria
    let action: () -> Void
    
    private var image: Image {
        switch bacteria.color {
            case .green:
                return Image(systemName: "chevron.up.circle.fill")
            case .red:
                return Image(systemName: "chevron.up.square.fill")
            default:
                return Image(systemName: "chevron.up.circle")
        }
    }
    
    var body: some View {
        ZStack {
            Button(action: action) {
                image
                    .resizable()
                    .foregroundColor(bacteria.color)
            }
            .buttonStyle(.plain)
            .frame(width: 32, height: 32)
            
            Rectangle()
                .fill(bacteria.color)
                .frame(width: 3, height: 8)
                .offset(y: -20)
        }
        .rotationEffect(.degrees(bacteria.direction.degrees))
    }
}

struct BacteriaView_Previews: PreviewProvider {
    static var previews: some View {
        BacteriaView(bacteria: Bacteria(row: .zero, column: .zero)) { }
        .frame(width: 40, height: 40)
    }
}
