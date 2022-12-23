//
//  BioBlitzApp.swift
//  BioBlitz
//
//  Created by Chris Brown on 12/22/22.
//

import SwiftUI

@main
struct BioBlitzApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
    }
}
