//
//  SwiftDataExampleApp.swift
//  SwiftDataExample
//
//  Created by ke on 1/19/25.
//

import SwiftUI

@main
struct SwiftDataExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
